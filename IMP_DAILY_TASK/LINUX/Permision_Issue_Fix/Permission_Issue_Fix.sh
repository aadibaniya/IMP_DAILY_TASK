# ================================
# Task 3: Permission Issue Fix
# Scenario: App cannot write to a directory
# ================================

# 1. Check directory permissions and ownership
ls -ld /path/to/directory

# Example output:
# drwxr-xr-- 2 root root 4096 Jan 3 13:00 myappdir
# -> App user cannot write because owner is root

# 2. Change ownership to application user
sudo chown appuser:appuser /path/to/directory

# 3. Fix permissions (owner can read, write, execute)
sudo chmod 755 /path/to/directory

# (Optional: More secure – only app user can access)
# sudo chmod 700 /path/to/directory

# 4. Verify permissions after changes
ls -ld /path/to/directory

# 5. Switch to application user to test access
sudo -u appuser bash

# 6. Try writing to the directory
cd /path/to/directory
touch testfile

# If no error → permission issue fixed

# 7. Clean up test file
rm testfile

# 8. Exit from app user shell
exit

# ================================
# Real-world DevOps One-Liner Fix
# ================================

sudo chown -R appuser:appuser /path/to/directory && sudo chmod -R 755 /path/to/directory

