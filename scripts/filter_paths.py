#!/usr/bin/env python3
"""Small cli utility to copy all files that match a set of extensions to a given directory"""


import os
import shutil
import argparse


def filter(source_dir, dest_dir, extensions=(".jpg", ".png", ".jpeg", ".mp4", ".doc", ".ppt", ".piv", ".bmp", ".gif", ".avi", ".mov")):
    for subdir, dirs, files in os.walk(source_dir):
        for filename in files:
            filepath = os.path.join(subdir, filename)
            print(filepath)
            if any((filepath.endswith(ext) for ext in extensions)):
                dest_fpath = os.path.join(dest_dir, filepath)
                os.makedirs(os.path.dirname(dest_fpath), exist_ok=True)
                shutil.copy(filepath, dest_fpath)


if __name__ == "__main__":
    print("Parsing args")
    parser = argparse.ArgumentParser()
    parser.add_argument("src", type=str)
    parser.add_argument("dst", type=str)
    args = parser.parse_args()
    print("Start filtering")
    filter(args.src, args.dst)
