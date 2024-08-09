#!/bin/bash

# Configuration
LOG_DIR="./Log_dir"       # Directory containing the logs
ARCHIVE_DIR="./Archived_logs"  # Directory to store archived logs
RETENTION_DAYS=1              # Number of days to retain logs
LOGFILE="Logfile.log"            # Name of the log file to rotate

# Ensure the archive directory exists
mkdir -p "$ARCHIVE_DIR"

# Get the current date
CURRENT_DATE=$(date +'%Y%m%d')

# Rotate the log file
mv "$LOG_DIR/$LOGFILE" "$ARCHIVE_DIR/$LOGFILE.$CURRENT_DATE"
echo "Log file rotated: $LOGFILE.$CURRENT_DATE"

# Compress old log files
find "$ARCHIVE_DIR" -type f -name "$LOGFILE.*" -not -name "*.gz" -exec gzip {} \;
echo "Old log files compressed."

# Delete logs older than the specified retention period
find "$ARCHIVE_DIR" -type f -name "$LOGFILE.*.gz" -mtime +$RETENTION_DAYS -exec rm {} \;
echo "Logs older than $RETENTION_DAYS days deleted."

# Restart the logging service (optional)
# service myapp restart

echo "Log management tasks completed."
