# Student Attendance Tracker Deployment Engine

An automated Infrastructure as Code (IaC) engine built to deploy an attendance tracking application workspace.

## Project Architecture Component Map

The root of your repository contains:
* `setup_project.sh`  
  The automation pipeline script that accepts a suffix parameter.
* `README.md`  
  The project description and user guide file.

The script builds your project structure directly inside:
* `setup/`  
  The parent directory housing all generated project environments.

Inside the `setup/` directory, it deploys:
* `setup/attendance_tracker_<project_name>/`  
  The specific output folder generated based on your script input.

Inside this output folder, it sets up the application script:
* `attendance_checker.py`  
  The core Python program running calculations and alerts.

It also creates a sub-folder for settings:
* `Helpers/`  
  A folder to store project resources.
* `Helpers/assets.csv`  
  A data file with student records.
* `Helpers/config.json`  
  A configuration file updated by user inputs.

Finally, it creates a sub-folder for output:
* `reports/`  
  A folder to hold system files.
* `reports/reports.log`  
  A tracking file that logs all alerts.

## Execution Workflow

To launch the engine, you must pass a custom project name suffix as an argument:

```bash
chmod +x setup_project.sh
./setup_project.sh <project_name>
