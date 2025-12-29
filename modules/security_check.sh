FAIL_COUNT=$(grep "Failed password" /var/log/secure | wc -l)

if [ "$FAIL_COUNT" -gt "$FAILED_LOGIN_LIMIT" ]; then
  log "Possible SSH brute-force detected"
fi
