import os
# import difflib

HOME_DIR = "/Users/tyler.yep"
DOTFILES = [
    ".config/fish/config.fish",
    ".bash_profile",
    ".bashrc",
    ".git-prompt.sh",
    ".gitconfig",
    ".vimrc",
]


def diff(print_diffs: bool = False) -> None:
    for dotfile in DOTFILES:
        no_match = False
        root_name = os.path.join(HOME_DIR, dotfile)
        with open(root_name) as f1, open(dotfile) as f2:
            # z = difflib.SequenceMatcher(None, f1.read(), f2.read())
            a = f1.readlines()
            b = f2.readlines()
            for i in range(min(len(a), len(b))):
                if a[i] != b[i]:
                    no_match = True
                    if print_diffs:
                        print(a[i], b[i])
        if no_match:
            print(dotfile)


if __name__ == "__main__":
    diff()
