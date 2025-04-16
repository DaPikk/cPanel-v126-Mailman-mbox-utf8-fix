# cPanel-v126-Mailman-mbox-utf8-fix
This bundle includes scripts to scan and fix Mailman `.mbox` files in cPanel environments, particularly those using Mailman 2.x on cPanel v126+.

## ✅ Features

- Scans all mailing lists under:
  `/usr/local/cpanel/3rdparty/mailman/archives/{private|public}/`
- Detects non-UTF-8 `.mbox` files inside each mailing list
- Automatically re-encodes to UTF-8
- Creates `.bak` backups before fixing
- Outputs log to `/var/log/mailman_encoding_fix.log`

## 📦 Included Scripts

### 1. scan_and_fix_mailman.sh
Main script that finds all `.mbox` files under every mailing list archive and fixes encoding issues.

### 2. scan_mailman_archives.py
Detects file encoding using `chardet`.

### 3. fix_mbox_encoding.py
Fixes the `.mbox` file in place and creates a backup.

## 🧰 Setup Instructions

1. Extract the bundle:
   ```
   tar -xzf cPanel-v126-Mailman-mbox-utf8-fix-main.zip
   ```

2. Move scripts to a system path:
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

## 📝 Logs

- All actions are logged to `/var/log/mailman_encoding_fix.log`
- Ensure write permissions for that path

## 🛡️ Safe to Use

- Every `.mbox` file is backed up before modification
- Only `.mbox` files that fail UTF-8 validation are re-encoded

Make sure the user running the script has write permission there, or change the path in `scan_and_fix_mailman.sh`.
