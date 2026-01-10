# ==================================================
# Task 3: Permission Issue Fix
# Scenario: Application cannot write to a directory
# ==================================================

# Step 1: Check directory permissions and ownership
# -l  → long listing format
# -d  → show directory itself, not its contents
ls -ld /path/to/directory

# Example output:
# drwxr-xr-- 2 root root 4096 Jan 3 13:00 myappdir
#
# Explanation:
# d         → directory
# rwx       → owner permissions (read, write, execute)
# r-x       → group permissions (read, execute)
# r--       → others permissions (read only)
# root root → owner and group
#
# Problem:
# Application user does not have write (w) permission,
# so the app cannot create or modify files.

# --------------------------------------------------

# Step 2: Change ownership to the application user
# chown → change owner and group
# appuser:appuser → new owner and group
sudo chown appuser:appuser /path/to/directory

# This allows the application user to control the directory.

# --------------------------------------------------

# Step 3: Fix directory permissions
# chmod → change permissions
# 7 → rwx (read, write, execute) for owner
# 5 → r-x (read, execute) for group
# 5 → r-x (read, execute) for others
sudo chmod 755 /path/to/directory

# Alternative (more secure):
# Only the app user can access the directory
# sudo chmod 700 /path/to/directory

# --------------------------------------------------

# Step 4: Verify updated permissions and ownership
ls -ld /path/to/directory

# Expected result:
# drwxr-xr-x appuser appuser /path/to/directory

# --------------------------------------------------

# Step 5: Switch to the application user
# This simulates how the application runs in real life
sudo -u appuser bash

# --------------------------------------------------

# Step 6: Test write access
# cd → move into the directory
# touch → create an empty file (tests write permission)
cd /path/to/directory
touch testfile

# If no error appears, write permission is working.

# --------------------------------------------------

# Step 7: Clean up after testing
rm testfile

# --------------------------------------------------

# Step 8: Exit the application user shell
exit

# ==================================================
# Real-World DevOps One-Liner (Common Production Fix)
# ==================================================
# -R → apply recursively to all files and folders

sudo chown -R appuser:appuser /path/to/directory && sudo chmod -R 755 /path/to/directory

