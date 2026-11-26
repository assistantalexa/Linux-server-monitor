# Linux Server Monitoring and Automation

## Project Overview
A beginner-friendly DevOps project that monitors Linux server health and automates monitoring and report generation using Bash scripting and Cron.

## Features

- Monitor CPU usage
- Monitor memory usage
- Monitor disk usage
- Check server uptime
- Store monitoring data in timestamped logs
- Generate daily monitoring reports
- Check CPU, memory, and disk usage against configurable thresholds
- Record high-usage warnings in a separate alert log
- Automate monitoring every 5 minutes using Cron
- Generate daily reports at 11:00 PM using Cron
- Monitor CPU usage using Python
- Calculate memory usage using Python
- Calculate disk usage using Python
- Generate automated Python server health reports
- Detect resource threshold violations using Python
- Record Python alerts in a separate alert log
- Schedule Python health reports daily at 10:00 PM using Cron

## Technologies Used

- Linux (Ubuntu / WSL)
- Bash Scripting
- Python 3
- Cron Jobs
- Git and GitHub

## Project Structure
```text
linux-server-monitor/
├── scripts/
│   ├── monitor.sh
│   └── generate_report.sh
├── logs/
│   ├── monitor.log
│   ├── cron.log
│   └── alerts.log
├── reports/
└── README.md
```

## How to Run

Clone the repository:

```bash
git clone https://github.com/assistantalexa/Linux-server-monitor.git
cd linux-server-monitor
```

Make scripts executable:

```bash
chmod +x scripts/monitor.sh
chmod +x scripts/generate_report.sh
```

Run monitoring:

```bash
bash scripts/monitor.sh
```

Generate a report:

```bash
bash scripts/generate_report.sh
```

## Configuration
The default CPU, memory, and disk usage warning thresholds are set to 80% in `scripts/monitor.sh`. These can be changed as needed.

## Automation
Cron is configured to:
- Run server monitoring every 5 minutes
- Generate a report every day at 11:00 PM

## Learning Outcomes
- Linux system monitoring
- Bash scripting
- Log management
- Cron job scheduling
- Basic automation and alerting
