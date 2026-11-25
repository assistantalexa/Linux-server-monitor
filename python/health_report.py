import os
import platform
import shutil
from datetime import datetime

print("=" * 45)
print("       LINUX SERVER HEALTH REPORT")
print("=" * 45)

# Current date and time
print("Date:", datetime.now().strftime("%Y-%m-%d %H:%M:%S"))

# Operating system information
print("Operating System:", platform.system())
print("Hostname:", platform.node())

# CPU information
print("CPU Cores:", os.cpu_count())
# CPU usage information
with open("/proc/stat", "r") as file:
    cpu_values = list(map(int, file.readline().split()[1:]))

idle_time = cpu_values[3]
total_time = sum(cpu_values)

import time
time.sleep(1)

with open("/proc/stat", "r") as file:
    cpu_values_new = list(map(int, file.readline().split()[1:]))

idle_time_new = cpu_values_new[3]
total_time_new = sum(cpu_values_new)

cpu_usage = (
    1 - (idle_time_new - idle_time) /
    (total_time_new - total_time)
) * 100

print(f"CPU Usage: {cpu_usage:.2f}%")
# Memory information
with open("/proc/meminfo", "r") as file:
    for line in file:
        if line.startswith("MemTotal"):
            total_memory = int(line.split()[1]) // 1024
        elif line.startswith("MemAvailable"):
            available_memory = int(line.split()[1]) // 1024

used_memory = total_memory - available_memory
memory_usage = (used_memory / total_memory) * 100

print(f"Memory Usage: {memory_usage:.2f}%")

# Disk information
total, used, free = shutil.disk_usage("/")

disk_usage = (used / total) * 100

print(f"Disk Usage: {disk_usage:.2f}%")

print("=" * 45)
print("       HEALTH REPORT COMPLETED")
print("=" * 45)
# Save report to a file
report_dir = "reports"
os.makedirs(report_dir, exist_ok=True)

report_file = os.path.join(
    report_dir,
    f"python-report-{datetime.now().strftime('%Y-%m-%d')}.txt"
)

with open(report_file, "w") as file:
    file.write("Linux Server Health Report\n")
    file.write(f"Date: {datetime.now()}\n")
    file.write(f"Operating System: {platform.system()}\n")
    file.write(f"Hostname: {platform.node()}\n")
    file.write(f"CPU Cores: {os.cpu_count()}\n")
    file.write(f"Memory Usage: {memory_usage:.2f}%\n")
    file.write(f"Disk Usage: {disk_usage:.2f}%\n")

print(f"\nReport saved successfully: {report_file}")
# Resource threshold alerts
CPU_THRESHOLD = 80
MEMORY_THRESHOLD = 80
DISK_THRESHOLD = 80

alerts = []
if cpu_usage >= CPU_THRESHOLD:
    alerts.append(
        f"WARNING: CPU usage is HIGH: {cpu_usage:.2f}%"
    )
if memory_usage >= MEMORY_THRESHOLD:
    alerts.append(
        f"WARNING: Memory usage is HIGH: {memory_usage:.2f}%"
    )

if disk_usage >= DISK_THRESHOLD:
    alerts.append(
        f"WARNING: Disk usage is HIGH: {disk_usage:.2f}%"
    )

# Save alerts if any threshold is exceeded
if alerts:
    alert_file = "logs/python-alerts.log"

    with open(alert_file, "a") as file:
        for alert in alerts:
            file.write(f"{datetime.now()} - {alert}\n")
            print(alert)

    print("Alerts saved successfully!")
else:
    print("Server health is NORMAL. No alerts detected.")
