# cPanel-v126-Mailman-mbox-utf8-fix
This bundle includes scripts to scan and fix Mailman `.mbox` files in cPanel environments, particularly those using Mailman 2.x on cPanel v126+.

## Included Scripts

### 1. scan_and_fix_mailman.sh
Main script that loops through all users in `/home/`, checks for Mailman archives, and scans/fixes any `.mbox` files with non-UTF-8 encodings.

### 2. scan_mailman_archives.py
Python script to detect the encoding of `.mbox` files using `chardet`.

### 3. fix_mbox_encoding.py
Fixes `.mbox` files by detecting the correct encoding, converting to UTF-8, and replacing the original file (while backing it up).

## Setup Instructions

1. Extract the bundle:
   ```
   tar -xzf mailman_encoding_fix_bundle.tar.gz
   ```

2. Move scripts to a system path (e.g., /usr/local/bin):
   ```
   sudo mv *.sh *.py /usr/local/bin/
   ```

3. Make them executable:
   ```
   chmod +x /usr/local/bin/*.sh /usr/local/bin/*.py
   ```

4. Install Python dependency:
   ```
   pip install chardet
   ```

5. Run the script manually:
   ```
   /usr/local/bin/scan_and_fix_mailman.sh
   ```

6. (Optional) Add to crontab:
   ```
   @weekly /usr/local/bin/scan_and_fix_mailman.sh
   ```

## Logs

The script logs all actions to:
```
/var/log/mailman_encoding_fix.log
```

Make sure the user running the script has write permission there, or change the path in `scan_and_fix_mailman.sh`.
