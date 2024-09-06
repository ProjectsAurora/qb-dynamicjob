local QBCore = exports['qb-core']:GetCoreObject()

-- Event to check ingredients and start crafting
RegisterNetEvent('qb-dynamicjobs:checkIngredientsAndStartCrafting', function(itemName, locationName, craftingTime)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local location = Config.JobLocations[locationName]
    local recipe = Config.Recipes[itemName]

    if not location or not recipe then
        print("Error: Invalid location or recipe.")
        return
    end

    -- Check if the player has the required ingredients
    local hasIngredients = true
    for _, ingredient in ipairs(recipe.ingredients) do
        local item = Player.Functions.GetItemByName(ingredient.name)
        if not item or item.amount < ingredient.amount then
            hasIngredients = false
            break
        end
    end

    if not hasIngredients then
        TriggerClientEvent('QBCore:Notify', src, "You don't have the required ingredients.", "error")
        return
    end

    -- Notify player that crafting has started
    TriggerClientEvent('QBCore:Notify', src, "Crafting started. Please wait...", "info")

    -- Notify client to start the progress bar and animation
    TriggerClientEvent('qb-dynamicjobs:startCraftingClient', src, {
        itemName = itemName,
        craftingTime = craftingTime
    })

    -- Start crafting process
    Citizen.CreateThread(function()
        Citizen.Wait(craftingTime * 1000)

        -- Remove ingredients
        for _, ingredient in ipairs(recipe.ingredients) do
            Player.Functions.RemoveItem(ingredient.name, ingredient.amount)
        end

        -- Add crafted item
        Player.Functions.AddItem(itemName, 1)

        -- Notify player
        TriggerClientEvent('QBCore:Notify', src, "Crafting complete! You received 1x " .. recipe.label, "success")
    end)
end)

RegisterNetEvent('qb-dynamicjobs:server:bjobFridge', function(bjobFridge)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local stashName = 'DynamicFridge'

    if Player then
        exports['qb-inventory']:OpenInventory(src, stashName, {
            maxweight = 750000,
            slots = 50,
        })
    end
end)


RegisterNetEvent('qb-dynamicjobs:server:bjobFridge2', function(bjobFridge)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local stashName = 'DynamicFridge2'

    if Player then
        exports['qb-inventory']:OpenInventory(src, stashName, {
            maxweight = 750000,
            slots = 50,
        })
    end
end)




RegisterNetEvent('qb-dynamicjobs_billing:server:sendBilling', function(data)
    local src = source

    -- Validate the data properly (ensure both citizenid and amount exist and are valid)
    if not data or type(data) ~= "table" or not data.citizenid or not data.amount then
        TriggerClientEvent('QBCore:Notify', src, 'Billing failed: Invalid data.', 'error')
        return
    end

    local playerId = data.citizenid
    local amount = tonumber(data.amount)

    if not playerId or not amount or amount <= 0 then
        TriggerClientEvent('QBCore:Notify', src, 'Billing failed: Invalid data.', 'error')
        return
    end

    -- Debugging: Print the citizenid and amount
    print("Server received billing request for Citizen ID: " .. playerId .. " with amount: $" .. amount)

    -- Get the player sending the bill and the player being billed
    local billedPlayer = QBCore.Functions.GetPlayerByCitizenId(playerId)
    local currentPlayer = QBCore.Functions.GetPlayer(src)

    if currentPlayer and billedPlayer then
        local name = currentPlayer.PlayerData.charinfo.firstname .. ' ' .. currentPlayer.PlayerData.charinfo.lastname
        local citizenId = currentPlayer.PlayerData.citizenid

        -- Debugging: Print player information
        print("Current Player: " .. name .. " (ID: " .. citizenId .. ")")
        print("Billed Player: " .. billedPlayer.PlayerData.charinfo.firstname .. " (ID: " .. billedPlayer.PlayerData.citizenid .. ")")

        -- Send billing to the client (billedPlayer)
        TriggerClientEvent('qb-dynamicjobs_billing:client:sendBilling', billedPlayer.PlayerData.source, amount, name, citizenId)
    else
        -- Notify the client about an error (either player not found)
        TriggerClientEvent('QBCore:Notify', src, 'Billing failed: Player not found. Player ID: ' .. (playerId or "nil"), 'error')
    end
end)


-- Server-side billing event
RegisterNetEvent('qb-dynamicjobs_billing:server:sendBilling', function(data)
    local src = source
    local currentPlayer = QBCore.Functions.GetPlayer(src)

    -- Validate input data
    if not data or not data.citizenid or not data.amount then
        TriggerClientEvent('QBCore:Notify', src, 'Invalid billing data.', 'error')
        return
    end

    local amount = tonumber(data.amount)
    local citizenid = data.citizenid
    local billedPlayer = QBCore.Functions.GetPlayerByCitizenId(citizenid)

    if billedPlayer then
        -- Send billing details to the customer for confirmation
        TriggerClientEvent('qb-dynamicjobs_billing:client:sendBilling', billedPlayer.PlayerData.source, amount, currentPlayer.PlayerData.charinfo.firstname, citizenid)
    else
        TriggerClientEvent('QBCore:Notify', src, 'Citizen not found.', 'error')
    end
end)


RegisterNetEvent('qb-dynamicjobs_billing:server:doneBilling', function(data)
    local src = source
    local currentPlayer = QBCore.Functions.GetPlayer(src)

    -- Validate input data
    if not data or not data.amount or not data.cid or not data.payment_method then
        TriggerClientEvent('QBCore:Notify', src, 'Payment failed: Invalid data.', 'error')
        return
    end

    local amount = tonumber(data.amount)
    local paymentMethod = data.payment_method
    local paidPlayer = QBCore.Functions.GetPlayerByCitizenId(data.cid)

    if currentPlayer and paidPlayer then
        local jobName = currentPlayer.PlayerData.job.name

        -- Determine the payment method and update the account balance
        if paymentMethod == "cash" then
            if currentPlayer.Functions.RemoveMoney("cash", amount, "qb-dynamicjobs_billing-paid") then
                -- Update society account balance
                exports['qb-banking']:AddMoney(jobName, amount, 'Payment received')
                TriggerClientEvent("QBCore:Notify", src, "Payment successful. Cash received by society account.", "success")
            else
                TriggerClientEvent("QBCore:Notify", src, "Insufficient cash.", "error")
            end
        elseif paymentMethod == "bank" then
            if currentPlayer.Functions.RemoveMoney("bank", amount, "qb-dynamicjobs_billing-paid") then
                -- Update society account balance
                exports['qb-banking']:AddMoney(jobName, amount, 'Payment received')
                TriggerClientEvent("QBCore:Notify", src, "Payment successful. Bank transfer received by society account.", "success")
            else
                TriggerClientEvent("QBCore:Notify", src, "Insufficient bank funds.", "error")
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Payment failed: Player not found.", 'error')
    end
end)



--[[
RegisterNetEvent('qb-dynamicjobs_billing:server:doneBilling', function(data)
    local src = source
    local currentPlayer = QBCore.Functions.GetPlayer(src)

    -- Validate input data
    if not data or not data.amount or not data.cid or not data.payment_method then
        TriggerClientEvent('QBCore:Notify', src, 'Payment failed: Invalid data.', 'error')
        return
    end

    local amount = tonumber(data.amount)
    local paymentMethod = data.payment_method
    local paidPlayer = QBCore.Functions.GetPlayerByCitizenId(data.cid)

    if currentPlayer and paidPlayer then
        local cash = currentPlayer.PlayerData.money["cash"]
        local bank = currentPlayer.PlayerData.money["bank"]
        local currentPlayerFirstName = currentPlayer.PlayerData.charinfo.firstname

        if paymentMethod == "cash" then
            if cash >= amount then
                currentPlayer.Functions.RemoveMoney("cash", amount, "qb-dynamicjobs_billing-paid")
                paidPlayer.Functions.AddMoney("cash", amount, "qb-dynamicjobs_billing-received")
                TriggerClientEvent("QBCore:Notify", paidPlayer.PlayerData.source, "You received $" .. amount .. " from " .. currentPlayerFirstName .. " in cash!", "success")
                TriggerClientEvent("QBCore:Notify", src, "Payment successful.", "success")
            else
                TriggerClientEvent("QBCore:Notify", src, "Insufficient cash.", "error")
            end
        elseif paymentMethod == "bank" then
            if bank >= amount then
                currentPlayer.Functions.RemoveMoney("bank", amount, "qb-dynamicjobs_billing-paid")
                paidPlayer.Functions.AddMoney("bank", amount, "qb-dynamicjobs_billing-received")
                TriggerClientEvent("QBCore:Notify", paidPlayer.PlayerData.source, "You received $" .. amount .. " from " .. currentPlayerFirstName .. " via bank transfer!", "success")
                TriggerClientEvent("QBCore:Notify", src, "Payment successful.", "success")
            else
                TriggerClientEvent("QBCore:Notify", src, "Insufficient bank funds.", "error")
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Payment failed: Player not found.", 'error')
    end
end)
]]


------ MORE STORAGE


RegisterNetEvent('bd-burgershot:server:bbackStorage', function(bbackStorage)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local stashName = 'Dynamic Storage'

    if Player then
        exports['qb-inventory']:OpenInventory(src, stashName, {
            maxweight = 1000000,
            slots = 75,
        })
    end
end)

