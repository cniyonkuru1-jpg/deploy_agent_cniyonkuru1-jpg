#!/bin/bash

if [ -z "$1" ]; then
    echo "ERROR: Please provide a project name ."
    echo "Use: ./setup_project.sh <project_name>"
    exit 1
fi

DIR_NAME="attendance_tracker_$1"

cleanup() {
    echo -e "\n[INTERRUPTED] Cleaning up..."
    if [ -d "$DIR_NAME" ]; then
        tar -czf "${DIR_NAME}_archive.tar.gz" "$DIR_NAME" 2>/dev/null
        rm -rf "$DIR_NAME"
    fi
    exit 1
}
trap cleanup SIGINT

echo "=== Starting Automated Project Factory Pipeline ==="

if ! command -v python3 &> /dev/null; then
    echo "ERROR: Python 3 is not installed."
    exit 1
fi
echo "Health Check Passed: $(python3 --version) verified."

mkdir -p "$DIR_NAME/Helpers"
mkdir -p "$DIR_NAME/reports"

read -p "Enter custom warning limit (Press Enter for 75): " W_VAL
W_VAL=${W_VAL:-75}

read -p "Enter custom failure limit (Press Enter for 50): " F_VAL
F_VAL=${F_VAL:-50}

cat << EOF > "$DIR_NAME/Helpers/config.json"
{
    "thresholds": {
        "warning": $W_VAL,
        "failure": $F_VAL
    },
    "run_mode": "live",
    "total_sessions": 15
}
EOF

cat << EOF > "$DIR_NAME/Helpers/assets.csv"
Email,Names,Attendance Count,Absence Count
alice@example.com,Alice Johnson,14,1
bob@example.com,Bob Smith,7,8
charlie@example.com,Charlie Davis,4,11
diana@example.com,Diana Prince,15,0
EOF

cat << 'EOF' > "$DIR_NAME/attendance_checker.py"
import csv
import json
import os
from datetime import datetime

def run_attendance_check():
    # 1. Load Config
    with open('Helpers/config.json', 'r') as f:
        config = json.load(f)
        
    # 2. Archive old reports.log if it exists
    if os.path.exists('reports/reports.log'):
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        os.rename('reports/reports.log', f'reports/reports_{timestamp}.log.archive')
        
    # 3. Process Data
    with open('Helpers/assets.csv', mode='r') as f, open('reports/reports.log', 'w') as log:
        reader = csv.DictReader(f)
        total_sessions = config['total_sessions']
        
        log.write(f"--- Attendance Report Run: {datetime.now()} ---\n")
        
        for row in reader:
            name = row['Names']
            email = row['Email']
            attended = int(row['Attendance Count'])
            
            # Simple Math: (Attended / Total) * 100
            attendance_pct = (attended / total_sessions) * 100
            message = ""
            
            if attendance_pct < config['thresholds']['failure']:
                message = f"URGENT: {name}, your attendance is {attendance_pct:.1f}%. You will fail this class."
            elif attendance_pct < config['thresholds']['warning']:
                message = f"WARNING: {name}, your attendance is {attendance_pct:.1f}%. Please be careful."
                
            if message:
                if config['run_mode'] == "live":
                    log.write(f"[{datetime.now()}] ALERT SENT TO {email}: {message}\n")
                    print(f"Logged alert for {name}")
                else:
                    print(f"[DRY RUN] Email to {email}: {message}")

if __name__ == "__main__":
    run_attendance_check()
EOF

cat << EOF > "$DIR_NAME/reports/reports.log"
--- Attendance Report Run: 2026-02-06 18:10:01.468726 ---
[2026-02-06 18:10:01.469363] ALERT SENT TO bob@example.com: URGENT: Bob Smith, your attendance is 46.7%. You will fail this class.
[2026-02-06 18:10:01.469424] ALERT SENT TO charlie@example.com: URGENT: Charlie Davis, your attendance is 26.7%. You will fail this class.
EOF

echo "=== Project Factory Successfully Deployed ==="
echo "Target location: ./$DIR_NAME"
