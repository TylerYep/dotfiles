import difflib
from pathlib import Path

HOME_DIR = Path("/Users/tyler.yep")
DOTFILES = [
    ".config/fish/config.fish",
    ".bash_profile",
    ".bashrc",
    ".git-prompt.sh",
    ".gitconfig",
    ".vimrc",
]


def diff() -> None:
    for dotfile in DOTFILES:
        root_name = HOME_DIR / dotfile
        with open(root_name) as f1, open(dotfile) as f2:
            for line in difflib.unified_diff(f1.readlines(), f2.readlines()):
                print(line, end="")


if __name__ == "__main__":
    diff()
