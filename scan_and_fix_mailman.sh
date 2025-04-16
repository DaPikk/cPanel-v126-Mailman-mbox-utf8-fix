#!/bin/bash

PYTHON_FIXER="/usr/local/bin/fix_mbox_encoding.py"
PYTHON_SCANNER="/usr/local/bin/scan_mailman_archives.py"
LOGFILE="/var/log/mailman_encoding_fix.log"

echo "🕵️ Scanning all cPanel users for Mailman archives..." > "$LOGFILE"

for userdir in /home/*; do
    user=$(basename "$userdir")
    archive_dir="$userdir/mailman/archives/private"

    if [ -d "$archive_dir" ]; then
        echo "📁 Found Mailman archives for user: $user" | tee -a "$LOGFILE"

        find "$archive_dir" -type f -name "*.mbox" | while read -r mbox; do
            echo "  ↪ Checking: $mbox" | tee -a "$LOGFILE"

            detected_encoding=$(python3 "$PYTHON_SCANNER" "$mbox")
            if [[ "$detected_encoding" != "utf-8" ]]; then
                echo "  ❌ Non-UTF-8 detected ($detected_encoding), fixing..." | tee -a "$LOGFILE"
                python3 "$PYTHON_FIXER" "$mbox" >> "$LOGFILE" 2>&1
            else
                echo "  ✅ Already UTF-8." | tee -a "$LOGFILE"
            fi
        done
    fi
done

echo "✅ Scan complete." | tee -a "$LOGFILE"
