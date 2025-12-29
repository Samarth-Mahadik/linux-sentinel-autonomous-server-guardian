#!/bin/bash

# -------- CPU CHECK : PRODUCTION GRADE --------

# Take 2 samples to avoid false spike
CPU_1=$(top -bn1 | awk '/Cpu\(s\)/ {print $2 + $4}')
sleep 1
CPU_2=$(top -bn1 | awk '/Cpu\(s\)/ {print $2 + $4}')

CPU_AVG=$(echo "($CPU_1 + $CPU_2) / 2" | bc)
CPU_INT=${CPU_AVG%.*}

# Identify top CPU consumer (NO AUTO-KILL)
TOP_PROCESS=$(ps -eo pid,comm,%cpu --sort=-%cpu | awk 'NR==2 {print "PID="$1",PROC="$2",CPU="$3"%"}')

# Severity logic
if [ "$CPU_INT" -ge "$CPU_LIMIT" ] && [ "$CPU_INT" -lt 90 ]; then
    log WARNING "CPU high (${CPU_AVG}%). Top process: $TOP_PROCESS"

elif [ "$CPU_INT" -ge 90 ]; then
    log CRITICAL "CPU critical (${CPU_AVG}%). Immediate admin attention required. Top process: $TOP_PROCESS"

else
    log INFO "CPU normal (${CPU_AVG}%)"
fi

