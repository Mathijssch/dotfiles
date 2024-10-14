import pathlib  # Glob module does not detect dotfiles.
import os
import warnings
import difflib
HOME_DIR = "home"
CONFIG_DIR = ".config"
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


def _get_curr_dir() -> str:
    return os.path.split(os.path.abspath(__file__))[0]


def set_path():
    """Collect the current path and write it to the DOTENV environment variable in path.env"""

    current_dir = _get_curr_dir()
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


def process_existing(link, stats) -> bool:
    if not os.path.exists(link):
        return True
    print(f"File {link} already exists.")
    backup_file = link + "_BAK"
    response = input(f"Want to overwrite it? A backup of the current version will be stored as {backup_file} [y/N]")
    if response == "y":
        os.rename(link, backup_file)
        return True
    return False


def create_link_safely(link, file, stats):
    if not process_existing(link, stats):
        stats["already existing"] += 1
        return False
    print(f"Creating symlink {link} -> {file}")
    isdir = os.path.isdir(file)
    file = os.path.abspath(file)
    os.symlink(file, link, target_is_directory=isdir)
    stats["links created"] += 1


def create_links_to_home():
    exclude_list = get_exclude_list()

    stats = {"files detected": 0,
             "files ignored": 0,
             "links created": 0,
             "not a file": 0,
             "already existing": 0
             }
    for fileref in pathlib.Path(".").glob(f"{HOME_DIR}/*"):
        file = str(fileref)
        print(f"Processing {file}")
        stats["files detected"] += 1
        if excluded(exclude_list, file):
            print(f"Excluding {file}")
            stats["files ignored"] += 1
            continue
        file = os.path.abspath(file)
        if not os.path.isfile(file):
            print(f"{file} is not a file")
            stats["not a file"] += 1
            continue

        link = os.path.expanduser((os.path.join("~", os.path.split(file)[1])))
        create_link_safely(link, file, stats)
    _print_stats(stats)


def _print_stats(stats):
    print("-" * 80)
    for key, value in stats.items():
        print(f"{key:20s} | {value:5d}")
    print("-" * 80)


def create_links_to_configs():
    configs = pathlib.Path(".").joinpath(CONFIG_DIR)
    stats = {"configs detected": 0,
             "links created": 0,
             "skipped": 0,
             "already existing": 0
             }

    for config_dir in os.listdir(configs):
        config_dir = os.path.join(CONFIG_DIR, config_dir)
        stats["configs detected"] += 1
        response = input(f"Create link to config '{config_dir}' in the home directory? [Y/n]")
        if response.lower() == "n":
            stats["skipped"] += 1
            continue
        link = os.path.expanduser((os.path.join("~", CONFIG_DIR, os.path.split(config_dir)[1])))
        create_link_safely(link, config_dir, stats)
    _print_stats(stats)


def set_timetagger():
    curdir = _get_curr_dir()
    timetagger_env = os.path.join(curdir, "timetagger.env")
    if os.path.isfile(timetagger_env):
        with open(timetagger_env, "r") as f:
            timetagger_line = f.read()
        if timetagger_line:
            try:
                timetagger = timetagger_line.split("=")[-1].strip()
                if os.path.isdir(timetagger):
                    return
            except IndexError():
                pass
    new_path = input("Where is timetagger installed? (leave empty to ignore): ")
    if new_path:
        with open(timetagger_env, "w") as f:
            new_line = f"export TIMETAGGER_PATH={new_path}"
            print(f"Writing '{new_line}' to '{timetagger_env}'")
            f.write(new_line)


def main():
    set_path()
    set_timetagger()
    create_links_to_home()
    create_links_to_configs()


if __name__ == "__main__":
    main()
