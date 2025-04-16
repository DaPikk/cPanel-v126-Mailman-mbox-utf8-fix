#!/usr/bin/env python3

import argparse
import os
import shutil
import mailbox
import chardet

def detect_encoding(file_path, read_bytes=10000):
    with open(file_path, 'rb') as f:
        result = chardet.detect(f.read(read_bytes))
        return result['encoding'] or 'utf-8'

def convert_mbox_in_place(source_path):
    backup_path = source_path + ".bak"
    shutil.copy2(source_path, backup_path)
    print(f"[✓] Backup created: {backup_path}")

    encoding = detect_encoding(source_path)
    print(f"[✓] Detected encoding: {encoding}")

    temp_path = source_path + ".utf8tmp"
    mbox = mailbox.mbox(source_path, factory=None)

    with open(temp_path, 'w', encoding='utf-8') as out_file:
        for msg in mbox:
            try:
                out_file.write(msg.as_string() + '\n\n')
            except Exception:
                out_file.write(
                    msg.as_bytes().decode(encoding, errors='replace') + '\n\n'
                )

    shutil.move(temp_path, source_path)
    print(f"[✓] Fixed: {source_path}")

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("mbox_file", help="Path to .mbox file")
    args = parser.parse_args()

    if not os.path.exists(args.mbox_file):
        print(f"[!] File not found: {args.mbox_file}")
        return

    convert_mbox_in_place(args.mbox_file)

if __name__ == "__main__":
    main()
