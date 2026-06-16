# Student Attendance Tracker Deployment Engine

An automated Infrastructure as Code (IaC) engine built to deploy an attendance tracking application workspace.

## Project Architecture Component Map

The script creates a main folder named 
`attendance_tracker_classF`. 

Inside this root folder, it sets up 
the core application script:
* `attendance_checker.py`  
  The main Python program that runs the 
  attendance calculations and alerts.

It also creates a sub-folder for settings:
* `Helpers/`  
  A folder to store project resources.
* `Helpers/assets.csv`  
  A data file with student records.
* `Helpers/config.json`  
  A configuration file updated by user input thresholds.

Finally, it creates a sub-folder for output:
* `reports/`  
  A folder to hold system files.
* `reports/reports.log`  
  A tracking file that logs all alerts.
