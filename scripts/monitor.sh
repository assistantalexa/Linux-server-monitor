
#!/bin/bash

# Linux Server Monitoring Project

# Set project directory
PROJECT_DIR="$HOME/linux-server-monitor"
LOG_FILE="$PROJECT_DIR/logs/monitor.log"
ALERT_FILE="$PROJECT_DIR/logs/alerts.log"

# Create log directory if missing
mkdir -p "$PROJECT_DIR/logs"

# Threshold values
CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=80

# Get current date and time
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Get CPU usage
CPU_USAGE=$(LC_ALL=C top -bn1 | awk -F',' '/Cpu\(s\)/ {
    for (i=1; i<=NF; i++) {
        if ($i ~ /id/) {
            gsub(/[^0-9.]/, "", $i)
            print 100-$i
            exit
        }
    }
}')

# Get memory usage
MEM_USAGE=$(free | awk '/Mem:/ {
    printf "%.1f", ($3/$2)*100
}')

# Get disk usage
DISK_USAGE=$(df -P / | awk 'NR==2 {
    gsub("%", "", $5)
    print $5
}')

# Get server uptime
UPTIME=$(uptime -p)

# Display results
echo "Linux Server Monitoring"
echo "----------------------"
echo "Time: $TIMESTAMP"
echo "CPU Usage: ${CPU_USAGE}%"
echo "Memory Usage: ${MEM_USAGE}%"
echo "Disk Usage: ${DISK_USAGE}%"
echo "Server Uptime: $UPTIME"

# Check CPU threshold
if (( ${CPU_USAGE%.*} > CPU_THRESHOLD )); then
    WARNING="[$TIMESTAMP] WARNING: High CPU usage: ${CPU_USAGE}%"
    echo "$WARNING"
    echo "$WARNING" >> "$ALERT_FILE"
fi

# Check memory threshold
if (( ${MEM_USAGE%.*} > MEM_THRESHOLD )); then
    WARNING="[$TIMESTAMP] WARNING: High memory usage: ${MEM_USAGE}%"
    echo "$WARNING"
    echo "$WARNING" >> "$ALERT_FILE"
fi

# Check disk threshold
if (( DISK_USAGE > DISK_THRESHOLD )); then
    WARNING="[$TIMESTAMP] WARNING: High disk usage: ${DISK_USAGE}%"
    echo "$WARNING"
    echo "$WARNING" >> "$ALERT_FILE"
fi

# Save results to log
echo "[$TIMESTAMP] CPU=${CPU_USAGE}% MEM=${MEM_USAGE}% DISK=${DISK_USAGE}% UPTIME=$UPTIME" >> "$LOG_FILE"

