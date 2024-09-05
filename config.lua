
Config = {}

-- Define storage locations
Config.StorageLocation = {
    name = "BusinessStorage", -- Unique name for the storage
    coords = vector3(-1202.86, -895.66, 14.0), -- Coordinates for the storage location
    heading = 347.27, -- Heading angle for the zone
    minZ = 14.0, -- Minimum Z coordinate for the zone
    maxZ = 15.0, -- Maximum Z coordinate for the zone
    size = {x = 1.0, y = 1.0} -- Size of the target zone (width, height)
}

--CLOCK IN AND OUT LOCATIONS 

Config.BusinessClockLocations = {
    BusinessClock1 = {
        coords = vector3(-1193.34, -898.67, 14.0),
        size = vector3(1.0, 1.0, 2.0),
        heading = 347.27,
        job = "dynamic",
        events = {
            {
                event = "qb-dynamicjobs:client:ToggleDuty",
                icon = "fa-solid fa-clipboard-user",
                label = "Clock In/Out"
            },
            {
                event = "qb-bossmenu:client:OpenMenu",
                icon = "fa-solid fa-right-to-bracket",
                label = "Boss Menu",
                job = {['dynamic'] = 4}
            }
        }
    },
    BusinessClock2 = {
        coords = vector3(-1186.23, -896.44, 14.0),
        size = vector3(1.0, 1.0, 2.0),
        heading = 347.27,
        job = "dynamic",
        events = {
            {
                event = "qb-dynamicjobs:client:ToggleDuty",
                icon = "fa-solid fa-clipboard-user",
                label = "Clock In/Out"
            },
            {
                event = "qb-bossmenu:client:OpenMenu",
                icon = "fa-solid fa-right-to-bracket",
                label = "Boss Menu",
                job = {['dynamic'] = 4}
            }
        }
    }
}

---REGISTER LOCATIONS --- 
Config.Locations = {
    BurgershotRegister = {
        coords = vector3(-1196.27, -891.53, 14.0),
        size = vector3(0.9, 0.9, 2.0),
        heading = 335.05,
        job = "dynamic",
        event = "qb-dynamicjobs_billing:client:OpenBillingMenu", --- DONT CHANGE 
        icon = "fa-solid fa-cash-register",
        label = "Register"
    },
    Location2 = {
        coords = vector3(-1195.31, -893.66, 14.0),
        size = vector3(1.0, 1.0, 2.0),
        heading = 215.37,
        job = "dynamic",
        event = "qb-dynamicjobs_billing:client:OpenBillingMenu",  --- DONT CHANGE 
        icon = "fa-solid fa-cash-register",
        label = "Register 2"
    },
    Location3 = {
        coords = vector3(-250.47, -1700.23, 30.0),
        size = vector3(0.8, 0.8, 2.0),
        heading = 88.10,
        job = "dynamic",
        event = "qb-dynamicjobs_billing:client:OpenBillingMenu",  --- DONT CHANGE 
        icon = "fa-solid fa-cash-register",
        label = "Register 3"
    }
    -- Add more locations as needed
}


-- Job locations with associated crafting recipes
Config.JobLocations = {
    ["CraftingArea1"] = {
        coords = vector3(-1197.14, -899.93, 14.0),
        targetLabel = "Prep Station",
        recipes = {"laptop", "lettuce"} -- List of recipe names that can be crafted here
    },
    ["CraftingArea2"] = {
        coords = vector3(-1201.05, -898.76, 14.0),
        targetLabel = "Frying Station",
        recipes = {"steak", "laptop", "pork"} -- List of recipe names that can be crafted here
    },
    ["CraftingArea3"] = {
        coords = vector3(-1198.56, -902.41, 14.0),
        targetLabel = "Side Station",
        recipes = {"steak", "laptop", "pork"} -- List of recipe names that can be crafted here
    },
    ["CraftingArea4"] = {
        coords = vector3(-1198.14, -896.61, 14.0),
        targetLabel = "Drink Station",
        recipes = {"steak", "laptop", "pork"} -- List of recipe names that can be crafted here
    }
}

-- Recipes with required ingredients and other details
Config.Recipes = {
    ["laptop"] = {
        label = "Laptop",
        price = 5,
        craftingTime = 10, -- Time in seconds
        ingredients = {
            {name = "sandwich", amount = 1},
            {name = "vodka", amount = 1}
        }
    },
    ["lettuce"] = {
        label = "Lettuce",
        price = 7,
        craftingTime = 8, -- Time in seconds
        ingredients = {
            {name = "vegetables", amount = 1},
            {name = "water", amount = 1}
        }
    },
    ["steak"] = {
        label = "Steak",
        price = 20,
        craftingTime = 15, -- Time in seconds
        ingredients = {
            {name = "beef", amount = 2},
            {name = "spices", amount = 1}
        }
    },
    ["chicken"] = {
        label = "Chicken",
        price = 15,
        craftingTime = 12, -- Time in seconds
        ingredients = {
            {name = "chicken_meat", amount = 1},
            {name = "seasoning", amount = 1}
        }
    },
    ["pork"] = {
        label = "Pork",
        price = 18,
        craftingTime = 18, -- Time in seconds
        ingredients = {
            {name = "pork_meat", amount = 2},
            {name = "barbecue_sauce", amount = 1}
        }
    }
}
