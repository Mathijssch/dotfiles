import time
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler
import shutil
import os


class FileHandler(FileSystemEventHandler):

    def __init__(self, out_dir: str):
        self.output_dir = out_dir

    def on_created(self, event):
        if event.is_directory:
            return
        print(f'File {event.src_path} has been created. Copying to the destination directory...')
        copy_file(event.src_path, dest_directory=self.output_dir)

    def on_moved(self, event):
        if event.is_directory:
            return
        print(f'File {event.dest_path} has been moved. Copying to the destination directory...')
        copy_file(event.dest_path, dest_directory=self.output_dir)

    def on_modified(self, event):
        if event.is_directory:
            return
        print(f'File {event.src_path} has been modified. Copying to the destination directory...')
        copy_file(event.src_path, dest_directory=self.output_dir)


def copy_file(src_path, dest_directory):
    base_name = os.path.basename(src_path)
    dest_path = os.path.join(dest_directory, base_name)
    os.makedirs(os.path.dirname(dest_path), exist_ok=True)
    shutil.copy2(src_path, dest_path)
    print(f'File copied to {dest_path}')


if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser("autocopy", description="Watches the given input directory and automatically copies any changed file over to the output directory.")

    parser.add_argument("--input", "-i", help="Input directory to watch", type=str, required=True)
    parser.add_argument("--output", "-o", help="Output directory", type=str, required=True)
    parser.add_argument("--interval", help="Time interval in seconds", default=10, type=int)

    args = parser.parse_args()

    print("-" * 80)
    print(args)
    print("-" * 80)
    source_directory = args.input
    destination_directory = args.output
    sleep = args.interval

    event_handler = FileHandler(destination_directory)
    observer = Observer()
    observer.schedule(event_handler, source_directory, recursive=True)
    try:
        observer.start()
    except FileNotFoundError:
        raise ValueError(f"Provided directory {source_directory} does not exist.")

    try:
        print(f"Watching for changes in {source_directory}. Press Ctrl+C to stop.")
        while True:
            time.sleep(sleep)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()
