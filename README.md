# Automated_System_Health_Check
 Automated System Health Check
This project is a Bash script that automatically checks key system health indicators like CPU load, memory usage, running services, and open network ports.
It uses color-coded output to make results easy to understand at a glance.

📂 Features
✅ CPU Load Check — Monitors system load and alerts when thresholds are exceeded.

✅ Memory Usage Check — Displays memory usage percentage with safety levels.

✅ Running Services Check — Lists currently active services.

✅ Open Ports Check — Lists all open network ports.

✅ Colorful Output — Results are color-coded (green, yellow, red) for better readability.

⚙️ How to Run
bash
Copy
Edit
# Give permission to execute the script
chmod +x Automated_System_Health_Check.sh

# Run the script
./Automated_System_Health_Check.sh
✅ Make sure you are root or use sudo to see all services and ports properly.

📸 Example Output
bash
Copy
Edit
 Checking CPU ... 
Your CPU Load is 0.00, 0.03, 0.00
Your CPU is safe

Checking Memory Usage
Memory Usage Percent is: 34.00%
Your Memory Usage is Safe

Checking Running Services...
These services are currently running:
- sshd.service
- NetworkManager.service

Checking Open Network Ports...
- Port 22/tcp is open (SSH)
- Port 80/tcp is open (HTTP)
🛠️ Future Improvements
 Add Disk Usage Monitoring.

 Add a Report Save Option (output to a file).

 Email Notification if DANGER thresholds are exceeded.

✨ Why I Built This
I wanted a simple, fast tool to monitor the health of Linux servers automatically — without needing external tools like Nagios or Zabbix.
This script is useful for system administrators, DevOps engineers, penetration testers, or anyone managing Linux systems.
