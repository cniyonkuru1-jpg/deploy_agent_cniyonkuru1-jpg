# Student Attendance Tracker

An automated Infrastructure as Code (IaC) engine built to deploy an attendance tracking application workspace.
## Fault Tolerance & The Archive Trigger (`SIGINT`)

An edge case occurs if a user forces the script to stop in the middle of running (such as pressing `Ctrl + C`). To handle this edge case safely, the script uses built-in signal trapping (Lines 10–18).

### How the Cleanup Trigger Works:
**The Cleanup Trigger:** If an interruption happens, execution halts immediately and triggers the cleanup function.

### How the Archive Trigger Works:
**Archive Creation:** The script instantly bundles any half-made, partial folders into a compressed `.tar.gz` archive file (which acts just like a zip file).

The root of your repository contains:
* `setup_project.sh`  
 "The setup script that asks you to type a project name."
* `README.md`  
  The project description and user guide file.

The script builds your project structure directly inside:
* `setup/`  
  The parent directory housing all generated project environments.

Inside the `setup/` directory, it deploys:
* `setup/attendance_tracker_<project_name>/`  
  The specific output folder generated based on your script input (Line 8).

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

---

## Execution Workflow

To launch the engine, you must pass a custom project name suffix as an argument:

```bash
chmod +x setup_project.sh
./setup_project.sh <project_name>

video explaining the project
<img width="244" height="305" alt="Screenshot 2026-06-16 172706" src="https://github.com/user-attachments/assets/c5e75f4e-a531-4a7a-b370-cdfbf7d63f98" />

