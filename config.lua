
Config = {}
----- TO CHANGE YOUR JOB CHANGE THE JOB ON ALL CONFIG LABELED JOB =

----MAIN STORAGE
Config.StorageLocation = {
    name = "BusinessStorage", -- Unique name for the storage
    coords = vector3(-1202.86, -895.66, 14.0), -- Coordinates for the storage location
    heading = 347.27, -- Heading angle for the zone
    minZ = 14.0, -- Minimum Z coordinate for the zone
    maxZ = 15.0, -- Maximum Z coordinate for the zone
    size = {x = 1.0, y = 1.0}, -- Size of the target zone (width, height)
    job = "dynamic" -- Job requirement
}


-- TRAY STORAGE--- NO JOB AS PUBLIC
Config.OpenStorage = {
    BackStorage = {
        name = "Tray",
        coords = vector3(-1193.85, -894.51, 14.04),
        heading = 347.27,
        minZ = 14.0, 
        maxZ = 15.0,   
        size = {x = 0.5, y = 0.5} 
    }
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
                label = "Clock In/Out",
                job = "dynamic"
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
                label = "Clock In/Out",
                job = "dynamic"
            },
            {
                event = "qb-bossmenu:client:OpenMenu",
                icon = "fa-solid fa-right-to-bracket",
                label = "Boss Menu",
                job = {['dynamic'] = 4}
            }
        }
    }
    --- ADD MORE 
}

---REGISTER LOCATIONS --- 
Config.Locations = {
    Location1 = {
        coords = vector3(-1196.0, -891.34, 14.2),
        size = vector3(0.9, 0.9, 2.0),
        heading = 335.05,
        job = "dynamic",
        event = "qb-dynamicjobs_billing:client:OpenBillingMenu", --- DONT CHANGE UNLESS WANTING TO USE OTHER PAYMENT SYSTEM
        icon = "fa-solid fa-cash-register",
        label = "Register"
    },
    Location2 = {
        coords = vector3(-1194.7, -893.35, 14.2),
        size = vector3(1.0, 1.0, 2.0),
        heading = 215.37,
        job = "dynamic",
        event = "qb-dynamicjobs_billing:client:OpenBillingMenu",  --- DONT CHANGE 
        icon = "fa-solid fa-cash-register",
        label = "Register 2"
    },
    Location3 = {
        coords = vector3(-1193.4, -895.19, 14.2),
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
        recipes = {"bs_rimjob", "bs_creampie"}, -- List of recipe names that can be crafted here
        job = {['dynamic'] = 4} -- example of rank and job
    },
    ["CraftingArea2"] = {
        coords = vector3(-1201.05, -898.76, 14.0),
        targetLabel = "Frying Station",
        recipes = {"cookedpatty"}, -- List of recipe names that can be crafted here
        job = "dynamic"
    },
    ["CraftingArea3"] = {
        coords = vector3(-1198.56, -902.41, 14.0),
        targetLabel = "Side Station",
        recipes = {"bs_bleeder"}, -- List of recipe names that can be crafted here
        job = "dynamic"
    },
    ["CraftingArea4"] = {
        coords = vector3(-1198.14, -896.61, 14.0),
        targetLabel = "Drink Station",
        recipes = {"bs_vanillashake"}, -- List of recipe names that can be crafted here
        job = "dynamic"
    }
}

-- Recipes with required ingredients and other details
Config.Recipes = {
    ["bs_creampie"] = {
        label = "Apple Creampie",
        price = 5,
        craftingTime = 15, -- Time in seconds
        ingredients = {
            {name = "sugar", amount = 1},
            {name = "eggs", amount = 1}
        }
    },
    ["bs_bleeder"] = {
        label = "Bleeder Burger",
        price = 7,
        craftingTime = 8, -- Time in seconds
        ingredients = {
            {name = "salad", amount = 1},
            {name = "cheese", amount = 1},
            {name = "cookedpatty", amount = 1}
        }
    },
    ["cookedpatty"] = {
        label = "Cooked Burger Patty",
        price = 20,
        craftingTime = 30, -- Time in seconds
        ingredients = {
            {name = "beef", amount = 2},
            {name = "spices", amount = 1}
        }
    },
    ["bs_vanillashake"] = {
        label = "Vanilla Shake",
        price = 15,
        craftingTime = 10, -- Time in seconds
        ingredients = {
            {name = "sugar", amount = 1},
            {name = "milk", amount = 1}
        }
    },
    ["bs_rimjob"] = {
        label = "RimJob Doughnut",
        price = 18,
        craftingTime = 18, -- Time in seconds
        ingredients = {
            {name = "flour", amount = 2},
            {name = "sugar", amount = 1}
        }
    }
}
