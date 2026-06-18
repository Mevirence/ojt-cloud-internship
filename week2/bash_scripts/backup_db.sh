#!/bin/bash
# Backup script for expense_db
# Usage: ./backup_db.sh

DB_NAME="expense_db"
DB_USER="expense_user"
DB_PASS="StrongPassword123"
BACKUP_DIR="$HOME/db_backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/${DB_NAME}_backup_${TIMESTAMP}.sql"

mkdir -p "$BACKUP_DIR"

echo "Starting backup of $DB_NAME..."
mysqldump -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" > "$BACKUP_FILE"

if [ $? -eq 0 ]; then
    echo "Backup successful: $BACKUP_FILE"
else
    echo "Backup failed."
    exit 1
fi
