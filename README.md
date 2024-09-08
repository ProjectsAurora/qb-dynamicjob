# qb-dynamicjobs

**qb-dynamicjobs** is a versatile script for QBCore that allows server administrators and players to fine-tune and create custom jobs with ease through configuration files. This script eliminates the need for multiple job scripts by providing a single, highly customizable solution.

For questions or support, https://discord.gg/DrEVzXz5Gh

This script works hand in hand with my script QB-Grocery https://github.com/ProjectsAurora/qb-grocery

# QBCore Dynamic Jobs Script

A dynamic, job-based system for **QBCore Framework** that allows you to create custom crafting, billing, and storage locations specific to each job. The script is highly flexible, offering full customization of locations, job grades, and interactions. Perfect for any job or business type on your server.

## Features

- **Crafting Zones**: Players can craft job-specific items at designated crafting locations, each with its own unique recipes and crafting animations.
  
- **Billing System**: Job roles can charge customers via **Citizen ID** and **amount** input, making it ideal for jobs like mechanics, shopkeepers, or any service-based roles.
  
- **Storage Zones**: Job-specific storage locations allow employees to access secure storage areas. Only certain job grades can access these zones based on your configuration.
  
- **Custom Locations**: Every crafting, billing, and storage zone can be placed anywhere in the world. Configure the coordinates, job requirements, and access based on job grades.
  
- **Job Grades**: Control access to crafting stations and storage based on the job’s grades, giving you the ability to assign permissions to higher-level employees.

## Duplicating the Script for a New Job

To create a version of this script for a different job, you can quickly duplicate and modify it using **Visual Studio Code**:

### Step 1: Duplicate the Script

1. Copy the entire script folder and rename it to match your new job (e.g., `qb-dynamicjobs-mechanic` to `qb-dynamicjobs-electronics`).

### Step 2: Use Visual Studio Code to Replace Event Names

Open the duplicated script in **Visual Studio Code**. Use the **"Find and Replace"** feature to quickly rename events:

1. Press `Ctrl + Shift + F` to open the search panel.
2. Search for `qb-dynamicjobs` in the entire project.
3. Replace all instances of `qb-dynamicjobs` with your new job name (e.g., `qb-electronicsjobs`).
4. Click **"Replace All"** to update every occurrence in the script.

This will easily update all relevant events in **client.lua**, **server.lua**, and other files.

#### Example Event Change:

- Original event:
    ```lua
    RegisterNetEvent('qb-dynamicjobs:startCrafting')
    AddEventHandler('qb-dynamicjobs:startCrafting', function(data)
    ```

- After using **Replace All**:
    ```lua
    RegisterNetEvent('qb-electronicsjobs:startCrafting')
    AddEventHandler('qb-electronicsjobs:startCrafting', function(data)
    ```

### Step 3: Update Config for the New Job

Open the **config.lua** file and modify job-specific details such as crafting locations, job requirements, and recipes:

```lua
Config.JobLocations = {
    ["electronics_crafting"] = {
        coords = vector3(100.0, -200.0, 20.0),
        targetLabel = "Electronics Crafting",
        job = "electronics",
        jobGrades = {1, 2, 3},  -- Specify which job grades can access
        recipes = {"circuitboard", "battery"}
    }
}

ensure qb-dynamicjobs-electronics

### Step 4: Add to `server.cfg`

Finally, add the new script to your **server.cfg** file:

```plaintext
ensure qb-dynamicjobs-electronics


1. **Clone the repository** and duplicate the script for each job you want.
2. Use **Visual Studio Code** to quickly replace event names using **"Find and Replace"**.
3. Modify the **config.lua** file to customize the job locations, recipes, and job grades.
4. Add the script to your **server.cfg**.

