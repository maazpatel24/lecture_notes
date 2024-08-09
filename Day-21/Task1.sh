#!/bin/bash

LOGFILE="./Log_dir/Logfile.log"

echo "Running System Performance Metrics Check at $(date)" >> $LOGFILE

{
    echo "Disk Usage:"
    df -h
    echo ""

    echo "Memory Usage:"
    free -h
    echo ""

    echo "CPU Load:"
    top -b -n1 | grep "Cpu(s)"
} 2>&1 | tee -a $LOGFILE

echo "" >> $LOGFILE

echo "System Performance Metrics check complete. Check log file at $LOGFILE for details."