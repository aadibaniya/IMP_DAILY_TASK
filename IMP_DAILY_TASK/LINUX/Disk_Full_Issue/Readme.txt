==================================================
DISK FULL ISSUE (95%) – BEGINNER DETAILED NOTES
==================================================

WHAT IS A DISK FULL ISSUE?
-------------------------
When disk usage reaches 95%, the server has very
little free space left. This can cause:
- Applications to stop working
- Logs to stop writing
- Services to crash
- Server to become unstable

This is treated as a high-priority issue.

==================================================
OVERALL SAFE APPROACH
==================================================
1. Confirm disk is full
2. Identify where space is used
3. Find abnormal / unnecessary files
4. Archive important data (logs)
5. Delete only safe files
6. Confirm disk space is freed

==================================================
STEP 1 : CHECK DISK USAGE
==================================================
Command:
df -h

Explanation:
- Shows disk size, used space, free space
- Identifies which mount point is full

Why this step is important:
- You must know which filesystem is affected
- Cleaning the wrong directory will not help

Example:
If "/" is 95% full, investigation starts from "/"

==================================================
STEP 2 : CHECK DIRECTORY USAGE (SUMMARY)
==================================================
Command:
du -sh / 2>/dev/null

Explanation:
- Shows total disk usage of root filesystem
- Permission errors are ignored

Purpose:
- Confirms space usage inside "/"
- Prepares for deeper investigation

==================================================
STEP 3 : IDENTIFY ABNORMAL / HIGH USAGE
==================================================
Command:
du -ah / | sort -rh | head -20

Explanation:
- Lists top 20 largest files/directories
- Largest items appear at the top

What to look for:
- Very large log files
- Backup files
- Dump files
- Unexpected large directories

This step answers:
"What is consuming most of the disk?"

==================================================
STEP 4 : CHECK LOG DIRECTORY
==================================================
Command:
ls -lh /var/log

Explanation:
- Lists all log files with sizes
- Logs are a common cause of disk full issues

What to check:
- Logs with unusually large size
- Multiple rotated log files

==================================================
STEP 5 : IDENTIFY ROTATED & COMPRESSED LOGS
==================================================
Commands:
ls -lh /var/log/*.log*
ls -lh /var/log/*.gz

Explanation:
- .log.1, .log.2 = rotated log files
- .gz = compressed old logs

These files are usually safe to archive and delete

==================================================
STEP 6 : ARCHIVE OLD LOG FILES
==================================================
Command:
tar -czvf /backup/old_logs.tar.gz /var/log/*.log* /var/log/*.gz

Explanation:
- Combines multiple log files into one archive
- Compresses them to save space
- Keeps logs safe before deletion

Production rule:
"Always archive logs before deleting"

==================================================
STEP 7 : CONFIRM ARCHIVE CREATION
==================================================
Commands:
ls -lh /backup/old_logs.tar.gz
tar -tzf /backup/old_logs.tar.gz

Explanation:
- Confirms archive file exists
- Confirms logs are inside the archive

Never delete logs without confirmation

==================================================
STEP 8 : DELETE ROTATED / COMPRESSED LOGS
==================================================
Commands:
rm -f /var/log/*.log*
rm -f /var/log/*.gz

Warning:
- Do NOT delete active log files
- Delete only rotated and compressed logs

==================================================
STEP 9 : CONFIRM LOG DELETION
==================================================
Command:
ls -lh /var/log

Explanation:
- Confirms old logs are removed
- Active logs should still be present

==================================================
STEP 10 : VERIFY DISK SPACE IS FREED
==================================================
Command:
df -h

Expected Result:
- Disk usage is reduced
- Usage ideally below 80%

==================================================
BEGINNER MENTAL MODEL
==================================================
Think of disk cleanup like cleaning a room:
- Identify the messy room
- Find unnecessary items
- Pack important items safely
- Throw away garbage
- Confirm room is clean

==================================================
INTERVIEW 1-LINE ANSWER
==================================================
"I check disk usage, identify abnormal files,
archive old logs, delete safe files, and confirm
disk space is freed."

==================================================
END OF FILE
==================================================

