import argparse
import shutil
from pathlib import Path

from git import Repo

HOME_DIR = Path("/Users/tyler.yep")
DOTFILES = [
    ".config/fish",
    ".bash_profile",
    ".bashrc",
    ".git-prompt.sh",
    ".gitconfig",
    ".vimrc",
    ".pdbrc",
]


def remove_duplicate_files(destination: Path, filename: str) -> None:
    full_dest_path = destination / filename
    if full_dest_path.is_dir():
        shutil.rmtree(full_dest_path)
    elif full_dest_path.is_file():
        full_dest_path.unlink()


def copy_file_or_folder(source: Path, destination: Path, filename: str) -> None:
    full_src_path = source / filename
    full_dest_path = destination / filename
    if full_src_path.is_dir():
        shutil.copytree(full_src_path, full_dest_path)
    elif full_src_path.is_file():
        shutil.copy(full_src_path, full_dest_path)


def create_dotfiles(source: str, destination: str) -> None:
    src = HOME_DIR if source == "~" else Path(source)
    dest = HOME_DIR if destination == "~" else Path(destination)
    for filename in DOTFILES:
        remove_duplicate_files(dest, filename)
        copy_file_or_folder(src, dest, filename)


def init_pipeline() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Use imp to commit new configs and exp to use the saved configs."
    )
    parser.add_argument("mode", type=str, choices=["imp", "exp"], help="mode")
    parser.add_argument("--force", "-f", action="store_true")
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
