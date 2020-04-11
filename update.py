import os
import shutil
import argparse


DOTFILES = [
    '.config/fish',
    '.bash_profile',
    '.bashrc',
    '.git-prompt.sh',
    '.gitconfig',
    '.vimrc'
]


def remove_duplicate_files(destination, filename):
    full_dest_path = os.path.join(destination, filename)
    if os.path.isdir(full_dest_path):
        shutil.rmtree(full_dest_path)
    else:
        os.remove(full_dest_path)


def copy_file_or_folder(source, destination, filename):
    full_src_path = os.path.join(source, filename)
    full_dest_path = os.path.join(destination, filename)
    if os.path.isdir(full_src_path):
        shutil.copytree(full_src_path, full_dest_path)
    else:
        shutil.copy(full_src_path, full_dest_path)


def create_dotfiles(source, destination):
    if source == '~':
        source = '/Users/tyleryep'
    if destination == '~':
        destination = '/Users/tyleryep'
    for filename in DOTFILES:
        remove_duplicate_files(destination, filename)
        copy_file_or_folder(source, destination, filename)


def init_pipeline():
    parser = argparse.ArgumentParser(description='')
    parser.add_argument('mode', type=str, choices=['imp', 'exp'],
                        help='import mode')
    return parser.parse_args()


if __name__ == "__main__":
    args = init_pipeline()
    if args.mode == 'imp':
        create_dotfiles('~', '.')
    elif args.mode == 'exp':
        create_dotfiles('.', '~')
    else:
        raise ValueError
