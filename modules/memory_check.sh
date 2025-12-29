#!/bin/bash

# Load config
source /opt/linux_sentinel/config/sentinel.conf
LOGFILE="/opt/linux_sentinel/logs/sentinel.log"

# Function to log
log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOGFILE"
}

# Step 1: Get memory usage in %
MEM_USED=$(free | awk '/Mem/ {printf("%.0f"), $3/$2 * 100}')

# Step 2: Check threshold
if [ "$MEM_USED" -gt "$MEMORY_LIMIT" ]; then
    # Step 3: Identify top memory-consuming processes (Top 5)
    TOP_MEM=$(ps -eo pid,comm,%mem --sort=-%mem | head -n 6 | tail -n 5)

    # Step 4: Log memory warning + top processes
    log "[WARNING] Memory usage high: ${MEM_USED}%. Top memory-consuming processes:"
    while read -r line; do
        log "    $line"
    done <<< "$TOP_MEM"

    # Step 5: Optional safe self-healing
    # Industry safe approach: restart only known memory-leaking services
    for svc in $SERVICE_LIST; do
        MEM_SVC=$(ps -C $svc -o %mem= | awk '{sum+=$1} END {print sum}')
        MEM_SVC=${MEM_SVC%.*}
        if [ ! -z "$MEM_SVC" ] && [ "$MEM_SVC" -gt 50 ]; then
            log "[ACTION] High memory in service $svc ($MEM_SVC%). Restarting service."
            systemctl restart $svc
        fi
    done
fi

# Step 6: Optional info log when memory normal
if [ "$MEM_USED" -le "$MEMORY_LIMIT" ]; then
    log "[INFO] Memory usage normal: ${MEM_USED}%"
fi

