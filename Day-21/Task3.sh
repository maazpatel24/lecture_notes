#!/bin/bash

# Configuration
LOG_DIR="./Log_dir"                     # Directory containing the logs
ARCHIVE_DIR="./Archived_logs"           # Directory to store archived logs
RETENTION_DAYS=1                        # Number of days to retain logs
LOGFILE="Logfile.log"                   # Name of the log file to rotate
MAX_LOG_SIZE=10485760                   # Maximum log file size in bytes (10MB)
REPORT_FILE="./Reports/log_management_report.txt" # Report file

# Ensure the archive directory exists
mkdir -p "$ARCHIVE_DIR"

# Create or clear the report file
: > "$REPORT_FILE"

echo "Log Management Report - $(date)" >> "$REPORT_FILE"
echo "===================================" >> "$REPORT_FILE"

# Function to check log size and rotate if necessary
rotate_log() {
    local logfile="$1"
    if [ -f "$logfile" ]; then
        local logsize=$(stat -c%s "$logfile" 2>>"$REPORT_FILE")
        if [ $? -ne 0 ]; then
            echo "Error getting log file size: $logfile" >> "$REPORT_FILE"
            return 1
        fi

        if (( logsize > MAX_LOG_SIZE )); then
            local current_date=$(date +'%Y%m%d_%H%M%S')
            local archived_log="$ARCHIVE_DIR/$LOGFILE.$current_date"
            
            mv "$logfile" "$archived_log" 2>>"$REPORT_FILE"
            if [ $? -ne 0 ]; then
                echo "Error rotating log file: $logfile" >> "$REPORT_FILE"
                return 1
            fi
            
            echo "Rotated log file: $logfile to $archived_log" >> "$REPORT_FILE"
            
            # Compress the rotated log file
            gzip "$archived_log" 2>>"$REPORT_FILE"
            if [ $? -ne 0 ]; then
                echo "Error compressing log file: $archived_log" >> "$REPORT_FILE"
                return 1
            fi
            echo "Compressed log file: $archived_log.gz" >> "$REPORT_FILE"
            
            # Create a new log file
            touch "$logfile" 2>>"$REPORT_FILE"
            if [ $? -ne 0 ]; then
                echo "Error creating new log file: $logfile" >> "$REPORT_FILE"
                return 1
            fi
            echo "Created new log file: $logfile" >> "$REPORT_FILE"
        else
            echo "Log file size is within limits: $logfile (Size: $logsize bytes)" >> "$REPORT_FILE"
        fi
    else
        echo "Log file not found: $logfile" >> "$REPORT_FILE"
        return 1
    fi
    return 0
}

# Function to delete old logs
delete_old_logs() {
    find "$ARCHIVE_DIR" -type f -name "$LOGFILE.*.gz" -mtime +$RETENTION_DAYS -exec rm -v {} \; 2>>"$REPORT_FILE"
    if [ $? -ne 0 ]; then
        echo "Error deleting old logs" >> "$REPORT_FILE"
        return 1
    fi
    echo "Logs older than $RETENTION_DAYS days deleted." >> "$REPORT_FILE"
    return 0
}

# Main script execution
echo "Starting log management tasks..." >> "$REPORT_FILE"

rotate_log "$LOG_DIR/$LOGFILE"
delete_old_logs

echo "Log management tasks completed." >> "$REPORT_FILE"

# Display the report
cat "$REPORT_FILE"

