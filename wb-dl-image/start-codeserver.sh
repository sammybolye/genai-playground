#!/bin/bash

LOG_FILE="/tmp/code-server-$(date +%Y%m%d%H%M%S).log"

/usr/bin/code-server \
  --bind-addr 0.0.0.0:8888 \
  --disable-telemetry \
  --disable-update-check \
  --disable-workspace-trust \
  --disable-getting-started-override \
  --auth none \
  --trusted-origins "*" \
  /home/jupyter >> "$LOG_FILE" 2>&1 &

sleep 5  

echo "Code Server started. Logs are being written to $LOG_FILE"
