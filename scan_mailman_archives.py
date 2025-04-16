#!/usr/bin/env python3

import sys
import chardet

def detect_encoding(file_path, sample_size=10000):
    with open(file_path, 'rb') as f:
        raw = f.read(sample_size)
        try:
            raw.decode('utf-8')
            return 'utf-8'
        except UnicodeDecodeError:
            result = chardet.detect(raw)
            return result['encoding']

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: scan_mailman_archives.py /path/to/file.mbox")
        sys.exit(1)

    print(detect_encoding(sys.argv[1]))
