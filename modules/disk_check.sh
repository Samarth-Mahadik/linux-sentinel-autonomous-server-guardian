#!/bin/bash
# File: /opt/linux_sentinel/modules/disk_check.sh

LOGFILE="/opt/linux_sentinel/logs/sentinel.log"
DISK_LIMIT=80  # Configurable threshold
TARGET_PATH="/"  # Root path to monitor

# Logging function with level
log() {
  LEVEL=$1
  MSG=$2
  echo "$(date '+%Y-%m-%d %H:%M:%S') [$LEVEL] $MSG" >> "$LOGFILE"
}

# Get disk usage percentage
DISK_USED=$(df "$TARGET_PATH" | awk 'NR==2 {print $5}' | tr -d '%')

# Disk high logic
if [ "$DISK_USED" -gt "$DISK_LIMIT" ]; then
  log "CRITICAL" "Disk usage $DISK_USED% exceeded limit $DISK_LIMIT%."

  # Safe auto-clean: only log files older than 7 days, avoid system-critical logs
  CLEAN_COUNT=$(find /var/log -type f -name "*.log" -mtime +7 -print -delete | wc -l)
  log "INFO" "Auto-cleaned $CLEAN_COUNT old log files in /var/log."

  # Optional: notify admin
  /opt/linux_sentinel/alerts/alert.sh "Disk usage $DISK_USED% exceeded. $CLEAN_COUNT old logs cleaned."
else
  log "INFO" "Disk usage normal: $DISK_USED%"
fi

