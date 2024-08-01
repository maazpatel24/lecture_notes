#!/bin/bash

# Backup script for PostgreSQL database
 
# Variables
DB_NAME=$1
DB_USER=$2
DB_PASS=$3
BACKUP_DIR=$4
TIMESTAMP=$(date +"%F")
BACKUP_FILE=$BACKUP_DIR/$DB_NAME-$TIMESTAMP/backup.log

mkdir -p $BACKUP_DIR/$DB_NAME-$TIMESTAMP

# Create a backup
PGPASSWORD="$DB_PASS" pg_dump -U "$DB_USER" "$DB_NAME" > "$BACKUP_FILE"