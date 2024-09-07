local QBCore = exports['qb-core']:GetCoreObject()

-- Check and create crafting zones
Citizen.CreateThread(function()
    -- Ensure Config is loaded
    if not Config or not Config.JobLocations then
        print("Error: Config or JobLocations is not loaded.")
        return
    end

    -- Add crafting locations
    for locationName, location in pairs(Config.JobLocations) do
        exports['qb-target']:AddBoxZone(locationName, location.coords, 1.5, 1.5, {
            name = locationName,
            heading = 0,
            debugPoly = false, -- Set to true to visualize the zone in-game
            minZ = location.coords.z - 1.0,
            maxZ = location.coords.z + 1.0,
        }, {
            options = {
                {
                    type = "client",
                    event = "qb-dynamicjobs:openCraftingMenu",
                    icon = "fas fa-hammer",
                    label = location.targetLabel or "Unknown Location",
                    job = location.job, -- Add job requirement
                    locationName = locationName,
                }
            },
            distance = 2.5
        })
    end
end)

-- Event to open crafting menu and pass recipes
RegisterNetEvent("qb-dynamicjobs:openCraftingMenu")
AddEventHandler("qb-dynamicjobs:openCraftingMenu", function(data)
    local locationName = data.locationName
    local recipes = data.recipes

    -- Trigger crafting menu logic with recipes for this location
    TriggerEvent('qb-dynamicjobs:client:OpenCraftingMenu', locationName, recipes)
end)


-- Event to open the crafting menu
RegisterNetEvent('qb-dynamicjobs:openCraftingMenu', function(data)
    local locationName = data.locationName
    local location = Config.JobLocations[locationName]

    if not location then
        print("Error: No configuration found for location:", locationName)
        return
    end

    local targetLabel = location.targetLabel or "Unknown Location"
    local recipes = location.recipes

    if not recipes then
        print("Error: No recipes found for this location.")
        return
    end

    local menuOptions = {}
    for _, itemName in ipairs(recipes) do
        local recipe = Config.Recipes[itemName]
        if recipe then
            local requirements = "Requires:\n"
            for _, ingredient in ipairs(recipe.ingredients) do
                requirements = requirements .. ingredient.amount .. "x " .. ingredient.name .. "\n"
            end

            table.insert(menuOptions, {
                header = recipe.label, -- No price included
                icon = "fas fa-cogs",
                txt = requirements,
                params = {
                    event = 'qb-dynamicjobs:startCrafting',
                    args = {
                        itemName = itemName,
                        locationName = locationName,
                        craftingTime = recipe.craftingTime or 5
                    }
                }
            })
        else
            print("Error: Recipe not found for item:", itemName)
        end
    end

    -- Open the crafting menu with an icon in the header
    exports['qb-menu']:openMenu({
        {
            header = "Crafting Menu - " .. targetLabel,
            icon = "fas fa-tools", -- Add your desired icon here (example: "fas fa-tools")
            isMenuHeader = true
        },
        table.unpack(menuOptions)
    })
end)

-- Event to start crafting
RegisterNetEvent('qb-dynamicjobs:startCrafting', function(data)
    local itemName = data.itemName
    local locationName = data.locationName
    local craftingTime = data.craftingTime

    -- Request server to check ingredients and start crafting
    TriggerServerEvent('qb-dynamicjobs:checkIngredientsAndStartCrafting', itemName, locationName, craftingTime)
end)

RegisterNetEvent('qb-dynamicjobs:startCraftingClient', function(data)
    local craftingTime = data.craftingTime
    local itemName = data.itemName

    -- Define animation dictionaries and animations
    local animations = {
        {dict = 'mini@repair', anim = 'fixing_a_player'}, -- Fixing animation
        {dict = 'anim@amb@business@coc@coc_unpack_cut_left@', anim = 'coke_cut_v5_coccutter'}, -- Example coke cutting animation
        {dict = 'anim@amb@business@coc@coc_packing_hi@', anim = 'full_cycle_v3_pressoperator'} -- Example packing animation
    }

    -- Pick a random animation
    local chosenAnimation = animations[math.random(#animations)]

    -- Play the chosen animation
    local playerPed = PlayerPedId()
    RequestAnimDict(chosenAnimation.dict)
    while not HasAnimDictLoaded(chosenAnimation.dict) do
        Wait(100)
    end
    TaskPlayAnim(playerPed, chosenAnimation.dict, chosenAnimation.anim, 8.0, -8.0, craftingTime * 1000, 0, 0, false, false, false)

    -- Show progress bar
    exports['progressbar']:Progress({
        name = "crafting",
        duration = craftingTime * 1000,
        label = "Crafting...",
        useWhileDead = false,
        canCancel = false,  -- Disable cancellation
        controlDisables = {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        -- No onCancel function since we are preventing cancellation
    })
end)



-- Event to handle crafting cancellation
RegisterNetEvent('qb-dynamicjobs:cancelCrafting', function()
    -- Ensure the progress bar is stopped
    exports['progressbar']:Stop("crafting")

    -- Stop any ongoing animation
    local playerPed = PlayerPedId()
    ClearPedTasksImmediately(playerPed)
    print("Crafting canceled and animation stopped") -- Debugging
end)


-- Event to handle crafting cancellation
RegisterNetEvent('qb-dynamicjobs:cancelCrafting', function()
    -- Ensure the progress bar is stopped
    exports['progressbar']:Stop("crafting")

    -- Stop any ongoing animation
    local playerPed = PlayerPedId()
    ClearPedTasksImmediately(playerPed)
    print("Crafting canceled and animation stopped") -- Debugging
end)


-- Event to handle crafting cancellation
RegisterNetEvent('qb-dynamicjobs:cancelCrafting', function()
    -- Ensure the progress bar is hidden
    exports['progressbar']:Stop("crafting")

    -- Stop any ongoing animation
    local playerPed = PlayerPedId()
    ClearPedTasksImmediately(playerPed)
end)



-- Register each location from the config
for location, details in pairs(Config.Locations) do
    exports['qb-target']:AddBoxZone(location, details.coords, details.size.x, details.size.y, {
        name = location,
        heading = details.heading,
        debugPoly = false,
        minZ = details.coords.z - 2,
        maxZ = details.coords.z + 2,
    }, {
        options = {
            {
                type = "client",
                event = details.event,
                icon = details.icon,
                label = details.label,
                job = details.job,
            }
        },
        distance = 2.5
    })
end

-- Open the menu to charge a customer
RegisterNetEvent('qb-dynamicjobs_billing:client:OpenBillingMenu', function()
    local menuOptions = {
        {
            header = "Billing Menu",
            txt = "Charge a customer",
            icon = "fas fa-dollar-sign",  -- Add dollar sign icon here
            params = {
                event = "qb-dynamicjobs_billing:client:ChargeCustomer"
            }
        },
    }
    -- Trigger the menu
    TriggerEvent('qb-menu:client:openMenu', menuOptions)
end)


-- Input details for billing (Citizen ID and Amount)
RegisterNetEvent('qb-dynamicjobs_billing:client:ChargeCustomer', function()
    -- Open the qb-input form for citizen ID and amount only
    local input = exports['qb-input']:ShowInput({
        header = "Charge Customer",
        submitText = "Charge",
        inputs = {
            {
                text = "Citizen ID",   -- Visible label
                name = "citizenid",    -- Field name
                type = "text",         -- Input type
                isRequired = true      -- Required input
            },
            {
                text = "Amount",
                name = "amount",
                type = "number",        -- Ensure the correct data type is used
                isRequired = true
            }
        }
    })

    -- Proceed if input is not nil
    if input then
        -- Validate inputs
        local citizenid = input.citizenid
        local amount = tonumber(input.amount)

        if citizenid and citizenid ~= "" and amount and amount > 0 then
            -- Pass the input data to the server
            TriggerServerEvent('qb-dynamicjobs_billing:server:sendBilling', {citizenid = citizenid, amount = amount})
        else
            -- Notify about invalid input
            TriggerEvent('QBCore:Notify', "Invalid input: Check citizen ID and amount.", "error")
        end
    else
        -- No input or action canceled
        TriggerEvent('QBCore:Notify', "Action canceled", "error")
    end
end)


-- Handling billing information from the server
RegisterNetEvent('qb-dynamicjobs_billing:client:sendBilling', function(amount, name, citizenId)
    -- Show a confirmation prompt to the user
    local input = exports['qb-input']:ShowInput({
        header = "Billing Confirmation",
        submitText = "Pay",
        inputs = {
            {
                text = "Amount: $" .. tostring(amount),  -- Display amount as static text (not editable)
                name = "amount_label",  -- This is a label, not an input
                type = "label",  -- Use a type like "label" to indicate static content
                isRequired = false  -- No input required since it's just for display
            },
            {
                text = "Payment Method",
                name = "payment_method",
                type = "radio",
                options = {
                    { value = "cash", text = "Cash" },
                    { value = "bank", text = "Bank" }
                },
                isRequired = true
            }
        }
    })

    if input then
        local paymentMethod = input.payment_method

        if paymentMethod then
            -- Proceed with billing process
            TriggerServerEvent('qb-dynamicjobs_billing:server:doneBilling', {
                amount = amount,  -- Use the amount from the server (not editable by client)
                cid = citizenId,
                payment_method = paymentMethod
            })
        else
            TriggerEvent('QBCore:Notify', "Invalid payment details.", "error")
        end
    else
    --    TriggerEvent('QBCore:Notify', "Billing action canceled.", "error")
    end
end)



-- Register each BusinessClock location from the config
for location, details in pairs(Config.BusinessClockLocations) do
    exports['qb-target']:AddBoxZone(location, details.coords, details.size.x, details.size.y, {
        name = location,
        heading = details.heading,
        debugPoly = false,
        minZ = details.coords.z - 2,
        maxZ = details.coords.z + 2,
    }, {
        options = details.events,
        distance = 2.5
    })
end



RegisterNetEvent('qb-dynamicjobs:client:ToggleDuty', function()
    TriggerServerEvent("QBCore:ToggleDuty")
end)

----P
Citizen.CreateThread(function()
    if Config and Config.OpenStorage then
        local storage = Config.OpenStorage.BackStorage
        exports['qb-target']:AddBoxZone(storage.name, storage.coords, storage.size.x, storage.size.y, {
            name = storage.name,
            heading = storage.heading,
            debugPoly = false,
            minZ = storage.minZ,
            maxZ = storage.maxZ,
        }, {
            options = {
                {
                    type = "client",
                    event = "bd-burgershot:client:bbackStorage",
                    icon = "fa-solid fa-equals",
                    label = "Tray",
                    job = storage.job,
                },
            },
            distance = 3.
        })
    else
        print("Error: Config or Config.OpenStorage is nil.")
    end
end)

RegisterNetEvent("bd-burgershot:client:bbackStorage", function()
    TriggerServerEvent('bd-burgershot:server:bbackStorage')
end)

---Work Storage Per job set in config 
Citizen.CreateThread(function()
    if Config and Config.StorageLocation then
        exports['qb-target']:AddBoxZone(Config.StorageLocation.name, Config.StorageLocation.coords, Config.StorageLocation.size.x, Config.StorageLocation.size.y, {
            name = Config.StorageLocation.name,
            heading = Config.StorageLocation.heading,
            debugPoly = false,
            minZ = Config.StorageLocation.minZ,
            maxZ = Config.StorageLocation.maxZ,
        }, {
            options = {
                {
                    type = "client",
                    event = "qb-dynamicjobs:client:bjobFridge",
                    icon = "fa-solid fa-box",
                    label = "Storage",
                    job = Config.StorageLocation.job -- Job requirement from config
                }
            },
            distance = 2.5
        })
    else
        print("Error: Config or Config.StorageLocation is nil.")
    end
end)


RegisterNetEvent("qb-dynamicjobs:client:bjobFridge")
AddEventHandler("qb-dynamicjobs:client:bjobFridge", function()
    TriggerServerEvent('qb-dynamicjobs:server:bjobFridge')
end)
