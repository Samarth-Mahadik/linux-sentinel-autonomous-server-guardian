#!/bin/bash

source /opt/linux_sentinel/config/sentinel.conf

LOGFILE="/opt/linux_sentinel/logs/sentinel.log"
CRITICAL_ALERT=false

log() {
  LEVEL=$1
  MESSAGE=$2

  echo "$(date '+%Y-%m-%d %H:%M:%S') [$LEVEL] $MESSAGE" >> "$LOGFILE"

  if [ "$LEVEL" = "CRITICAL" ]; then
    CRITICAL_ALERT=true
  fi
}

# --- MODULE CALLS ---
source /opt/linux_sentinel/modules/cpu_check.sh
source /opt/linux_sentinel/modules/memory_check.sh
source /opt/linux_sentinel/modules/disk_check.sh
source /opt/linux_sentinel/modules/service_check.sh
source /opt/linux_sentinel/modules/security_check.sh

# --- ALERT CALL ---
if [ "$CRITICAL_ALERT" = true ]; then
  /opt/linux_sentinel/alerts/alert.sh
fi

