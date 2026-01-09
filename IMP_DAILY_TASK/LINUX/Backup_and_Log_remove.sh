===========================
MAINTENANCE SCRIPT DOC
===========================

# Task 5: Automated Backup + Log Cleanup

## Scenario
- Automate daily backup of application data
- Clean old logs to prevent disk full issues
- Backup directory: /var/www/app
- Backup storage: /backups
- Log directory: /var/log/myapp
- Backup retention: 7 days
- Log retention: 14 days

---

## Combined Maintenance Script (Backup + Log Cleanup)

#!/bin/bash

# VARIABLES
SOURCE_DIR="/var/www/app"
BACKUP_DIR="/backups"
DATE=$(date +%F)
BACKUP_FILE="app_backup_$DATE.tar.gz"
BACKUP_RETENTION_DAYS=7

LOG_DIR="/var/log/myapp"
LOG_RETENTION_DAYS=14

# ------------------------
# BACKUP SECTION
# ------------------------
echo "Starting backup: $(date)"
mkdir -p $BACKUP_DIR

# Option 1: Include directory + contents
# tar -czf $BACKUP_DIR/$BACKUP_FILE $SOURCE_DIR

# Option 2: Contents only (cleaner)
tar -czf $BACKUP_DIR/$BACKUP_FILE -C $SOURCE_DIR .

# Remove old backups
find $BACKUP_DIR -type f -mtime +$BACKUP_RETENTION_DAYS -name "app_backup_*.tar.gz" -delete
echo "Backup completed: $BACKUP_FILE"

# ------------------------
# LOG CLEANUP SECTION
# ------------------------
echo "Starting log cleanup: $(date)"
if [ -d "$LOG_DIR" ]; then
    find $LOG_DIR -type f -mtime +$LOG_RETENTION_DAYS -name "*.log" -delete
    echo "Old logs deleted"
else
    echo "Log directory $LOG_DIR not found, skipping log cleanup"
fi

echo "Maintenance completed: $(date)"

---

## TAR BACKUP METHODS: Differences

| Method | Archive Contents | Extracted Folder Paths | Use Case |
|--------|-----------------|-----------------------|----------|
| `$SOURCE_DIR` | Directory + all files inside | /tmp/var/www/app/... | Preserve full path; restore to original location |
| `-C $SOURCE_DIR .` | Only contents of directory | /tmp/file1.txt, folderA/... | Cleaner backup; extract anywhere without extra parent folders |

### Notes
1. `$SOURCE_DIR` method keeps the directory name in the archive.
2. `-C $SOURCE_DIR .` method archives only the contents, not the parent folder.
3. Both methods do **not throw errors** if `$SOURCE_DIR` is a directory.
4. Choose the method based on your restoration or migration needs.

---

## Cron Scheduling Example

- Run daily at 2 AM:

crontab -e

0 2 * * * /path/to/maintenance.sh

---

## Verification Steps

1. Check backups:

ls /backups

2. Check logs cleaned:

ls /var/log/myapp

3. Optional: Check cron logs:

grep CRON /var/log/syslog

---

End of Document




