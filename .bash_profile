source ~/.bashrc

# added by Miniconda3 installer
# export PATH="/Users/tyleryep/miniconda3/bin:$PATH"  # commented out by conda initialize

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/Users/tyleryep/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/Users/tyleryep/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "/Users/tyleryep/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/Users/tyleryep/miniconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<


export BASH_SILENCE_DEPRECATION_WARNING=1
export WORKON_HOME=$HOME/.virtualenvs

# This line might fail if you onboarded with ahoy. In this case, leave this line out.
source /usr/local/bin/virtualenvwrapper.sh

# Command line gitk-like viewer
alias gitk-text='git log --graph --pretty="tformat:%C(yellow)%h%Creset %Cgreen(%ar)%Creset %C(bold blue)<%an>%Creset %C(red)%d%Creset %s"'

# Sets default DJANGO_SETTINGS_MODULE for given projects
function export_django_settings_env () {
    if [ $1 = "brokeback" ]; then
        export DJANGO_SETTINGS_MODULE="settings.local.server"
    fi
}

# Automatically activate Git projects' virtual environments based on the
# directory name of the project. Virtual environment name can be overridden
# by placing a .venv file in the project root with a virtualenv name in it
# http://hmarr.com/2010/jan/19/making-virtualenv-play-nice-with-git/
function workon_cwd {
    # Check that this is a Git repo
    GIT_DIR=`git rev-parse --git-dir 2> /dev/null`
    if [ $? -eq 0 ]; then
        # Find the repo root and check for virtualenv name override
        GIT_DIR=`\cd $GIT_DIR; pwd`
        PROJECT_ROOT=`dirname "$GIT_DIR"`
        PROJECT_NAME=`basename "$PROJECT_ROOT"`
        # For rh repo, treat the current working directory as the project directory
        if [ "$PROJECT_NAME" = "rh" ]; then
            ENV_NAME="$(basename $(pwd))"
        else
            ENV_NAME="$PROJECT_NAME"
        fi
        if [ -f "$PROJECT_ROOT/.venv" ]; then
            ENV_NAME=`cat "$PROJECT_ROOT/.venv"`
        fi
        # Activate the environment only if it is not already active
        if [ "$VIRTUAL_ENV" != "$WORKON_HOME/$ENV_NAME" ]; then
            if [ -e "$WORKON_HOME/$ENV_NAME/bin/activate" ]; then
                workon "$ENV_NAME" && export CD_VIRTUAL_ENV="$ENV_NAME"
            fi
        export_django_settings_env $ENV_NAME
        fi
    elif [ $CD_VIRTUAL_ENV ]; then
        # We've just left the repo, deactivate the environment
        # Note: this only happens if the virtualenv was activated automatically
        deactivate && unset CD_VIRTUAL_ENV
    fi
}
# New cd function that does the virtualenv magic
function venv_cd {
    cd "$@" && workon_cwd
}
alias cd="venv_cd"

# Delete all the old .pyc files that could be causing you errors
alias clean_pyc="find . -name '*.pyc' -delete"

# Add arcanist to path (Change 'arc' to where you installed arcanist)
export PATH="$PATH:~/arc/arcanist/bin"

# Always add coverage if running arc diff
alias ad="arc diff --coverage --browse --skip-binaries"
alias submod="git submodule update --init --recursive"
alias ut="DJANGO_SETTINGS_MODULE=settings.local.server REUSE_DB=true ./manage.py test --nologcapture --nocapture"
alias mut="DJANGO_SETTINGS_MODULE=settings.local.server REUSE_DB=false ./manage.py test --nologcapture --noinput --nocapture"
