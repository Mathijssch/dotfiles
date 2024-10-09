import pathlib  # Glob module does not detect dotfiles.
import os
import warnings
import difflib
HOME_DIR = "home"
EXCLUDE_PATH = os.path.join(HOME_DIR, ".exclude")
DOTFILES = "DOTFILES"


def get_exclude_list() -> list[str]:
    try:
        with open(EXCLUDE_PATH, "r") as exclusions:
            return [line.strip() for line in exclusions.readlines()] + [os.path.split(EXCLUDE_PATH)[-1]]
    except FileNotFoundError():
        warnings.warn(f"Could not find exclusions file at {EXCLUDE_PATH}.")
        result = input("Continue anyway? [y/N]")
        if result == "y":
            return []
        else:
            exit(1)


def excluded(exclude_list: list[str], file: str):
    return os.path.split(file)[1] in exclude_list


def set_path():
    """Collect the current path and write it to the DOTENV environment variable in path.env"""

    current_dir = os.path.split(os.path.abspath(__file__))[0]
    path_file = os.path.join(current_dir, "home", "path.env")
    new_line = f"export DOTFILES={current_dir}"
    if os.path.isfile(path_file):
        with open(path_file, "r") as f:
            lines = f.readlines()

        if "\n".join(lines) == new_line:
            return

        cmp = [new_line]
        print(f"File {path_file} exists")
        d = difflib.Differ()
        diff = d.compare(lines, cmp)
        diff_print = '\n'.join(diff)
        response = input(f"Make the following change?\n{diff_print}\n[y/N]")
        if response != "y":
            print("Keeping the old value.")
            return
    with open(path_file, "w") as f:
        f.write(new_line)


def main():
    stats = {"files detected": 0,
             "files ignored": 0,
             "links created": 0,
             "not a file": 0,
             "already existing": 0
             }
    exclude_list = get_exclude_list()
    set_path()
    for fileref in pathlib.Path(".").glob(f"{HOME_DIR}/*"):
        file = str(fileref)
        print(f"Processing {file}")
        stats["files detected"] += 1
        if excluded(exclude_list, file):
            print(f"Excluding {file}")
            stats["ignored"] += 1
            continue
        file = os.path.abspath(file)
        if not os.path.isfile(file):
            print(f"{file} is not a file")
            stats["not a file"] += 1
            continue

        link = os.path.expanduser((os.path.join("~", os.path.split(file)[1])))
        if os.path.isfile(link) or os.path.islink(link):
            print(f"File {link} already exists. Skipping.")
            backup_file = link + "_BAK"
            response = input(f"Want to overwrite it? A backup of the current version will be stored as {backup_file} [y/N]")
            if response == "y":
                os.rename(link, backup_file)
            else:
                stats["already existing"] += 1
                continue
        print(f"Creating symlink {link} -> {file}")
        os.symlink(file, link)
        stats["links created"] += 1

    print("-" * 80)
    for key, value in stats.items():
        print(f"{key:20s} | {value:5d}")
    print("-" * 80)


if __name__ == "__main__":

    main()
