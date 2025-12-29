#!/bin/bash

source /opt/linux_sentinel/config/sentinel.conf

for svc in $SERVICE_LIST
do
  systemctl is-active --quiet $svc
  if [ $? -ne 0 ]; then
    systemctl restart $svc
    log CRITICAL "Service $svc was down and restarted."
  else
    log INFO "Service $svc is running."
  fi
done
