
#!/bin/bash

PROJECT_DIR="$HOME/linux-server-monitor"

LOG_FILE="$PROJECT_DIR/logs/monitor.log"
REPORT_DIR="$PROJECT_DIR/reports"

TODAY=$(date "+%Y-%m-%d")
REPORT_FILE="$REPORT_DIR/report-$TODAY.txt"

mkdir -p "$REPORT_DIR"

echo "Linux Server Monitoring Report" > "$REPORT_FILE"
echo "Date: $TODAY" >> "$REPORT_FILE"
echo "================================" >> "$REPORT_FILE"

grep -F "[$TODAY" "$LOG_FILE" >> "$REPORT_FILE"

echo "================================" >> "$REPORT_FILE"
echo "Report generated successfully!"
echo "Saved to: $REPORT_FILE"
