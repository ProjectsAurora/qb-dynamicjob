# qb-dynamicjobs

**qb-dynamicjobs** is a versatile script for QBCore that allows server administrators and players to fine-tune and create custom jobs with ease through configuration files. This script eliminates the need for multiple job scripts by providing a single, highly customizable solution.

## Features

- **Fridges and Storage:** Includes three storage options—one public and two job-specific storages. While the storage is limited to three, you can add unlimited crafting locations, clock-in points, and tills.
- **Custom Payment System:** Integrates with the business bank account, offering both cash and bank transaction options for a realistic financial structure.
- **Clock-in Systems:** Provides integrated clock-in systems for effective job tracking and role management.
- **Crafting & Recipe System:** Fully configurable crafting system where you can adjust crafting time, required items, and recipes. Supports adding and grading multiple crafting stations by job level.
- **Configurable Targets:** Targets within the job are fully configurable, allowing adaptation to any MLO for any job. Integration with **qb-grocery** for sourcing produce is seamless.
- **Realism:** Adds more realism to gameplay by simulating dynamic job environments and interactions.

## Dependencies

- **qb-target:** Required for target interactions and configuration.

## Installation

1. **Clone the Repository:**
    ```bash
    git clone https://github.com/yourusername/qb-dynamicjobs.git
    ```

2. **Add the Script to Your Resources Folder:**
    Copy the `qb-dynamicjobs` folder into your server's resources directory.

3. **Update Your `server.cfg`:**
    Add the following lines to ensure the script loads in the correct order:
    ```plaintext
    start qb-target
    start qb-dynamicjobs
    ```

4. **Install Dependencies:**
    Ensure you have `qb-target` installed and configured.

## Configuration

All configurations are managed through the `config.lua` file. You can adjust job locations, payment settings, crafting times, and more.

## Testing and Feedback

The script is currently in the testing phase with ongoing bug fixes. We are sharing a video and preview to gather feedback, ideas, and suggestions from the community. Your input is valuable!

## Contact

For questions or support, https://discord.gg/DrEVzXz5Gh
