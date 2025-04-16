#!/bin/bash

ARCHIVE_BASE="/usr/local/cpanel/3rdparty/mailman/archives/private"
PYTHON_FIXER="/usr/local/bin/fix_mbox_encoding.py"
PYTHON_SCANNER="/usr/local/bin/scan_mailman_archives.py"
LOGFILE="/var/log/mailman_encoding_fix.log"

echo "🔍 Scanning Mailman archives in: $ARCHIVE_BASE" > "$LOGFILE"

find "$ARCHIVE_BASE" -type f -name "*.mbox" | while read -r mbox; do
    echo "  ↪ Checking: $mbox" | tee -a "$LOGFILE"
    detected_encoding=$(python3 "$PYTHON_SCANNER" "$mbox")

    if [[ "$detected_encoding" != "utf-8" ]]; then
        echo "  ❌ Non-UTF-8 detected ($detected_encoding), fixing..." | tee -a "$LOGFILE"
        python3 "$PYTHON_FIXER" "$mbox" >> "$LOGFILE" 2>&1
    else
        echo "  ✅ Already UTF-8." | tee -a "$LOGFILE"
    fi
done

echo "✅ Archive scan complete." | tee -a "$LOGFILE"
