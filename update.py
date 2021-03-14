import os
import shutil
import argparse
from git import Repo

HOME_DIR = "/Users/tyler.yep"
DOTFILES = [
    ".config/fish",
    ".bash_profile",
    ".bashrc",
    ".git-prompt.sh",
    ".gitconfig",
    ".vimrc",
    ".pdbrc",
]


def remove_duplicate_files(destination: str, filename: str) -> None:
    full_dest_path = os.path.join(destination, filename)
    if os.path.isdir(full_dest_path):
        shutil.rmtree(full_dest_path)
    elif os.path.isfile(full_dest_path):
        os.remove(full_dest_path)


def copy_file_or_folder(source: str, destination: str, filename: str) -> None:
    full_src_path = os.path.join(source, filename)
    full_dest_path = os.path.join(destination, filename)
    if os.path.isdir(full_src_path):
        shutil.copytree(full_src_path, full_dest_path)
    else:
        shutil.copy(full_src_path, full_dest_path)


def create_dotfiles(source: str, destination: str) -> None:
    if source == "~":
        source = HOME_DIR
    if destination == "~":
        destination = HOME_DIR
    for filename in DOTFILES:
        remove_duplicate_files(destination, filename)
        copy_file_or_folder(source, destination, filename)


def init_pipeline() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Use imp to commit new configs and exp to use the saved configs."
    )
    parser.add_argument("mode", type=str, choices=["imp", "exp"], help="mode")
    parser.add_argument("force", "-f", action="store_true")
    return parser.parse_args()


def main() -> None:
    args = init_pipeline()
    if not args.force:
        repo = Repo(".")
        changed_files = [item.a_path for item in repo.index.diff(None)]
        if changed_files:
            raise RuntimeError(
                "Please commit changes before attempting to update dotfiles."
            )
    if args.mode == "imp":
        create_dotfiles("~", ".")
    elif args.mode == "exp":
        create_dotfiles(".", "~")
    else:
        raise ValueError


if __name__ == "__main__":
    main()
