#####################
#   Shell Aliases   #
#####################

alias fishedit 'vim ~/.config/fish/config.fish'
alias .fish 'cd ~/.config/fish/'
alias cd.. 'cd ..'
alias ccd 'cd'
alias filesize 'du -sh'
alias activ 'conda activate'
alias deac 'conda deactivate'
alias pylinta 'find . -iname "*.py" | xargs pylint'
alias jekyl 'bundle exec jekyll serve'
alias jup 'jupyter notebook'
alias pipbuild 'rm -r dist/; python setup.py sdist bdist_wheel; twine upload dist/*'
alias pipsize 'pip list | tail -n +3 | awk \'{print $1}\' | xargs pip show | grep -E \'Location:|Name:\' | cut -d \' \' -f 2 | paste -d \' \' - - | awk \'{print $2 "/" tolower($1)}\' | xargs du -sh 2> /dev/null'

##############
#   Github   #
##############

function _github
    if test -z $argv[1]
        cd ~/Documents/Github/
    else
        cd ~/Documents/Github/$argv[1]
    end
end

function _status
    find ~/Documents/Github/$argv[1] -name .git -execdir git status \;
end

function _summary
    find ~/Documents/Github/ -maxdepth 1 -mindepth 1 -type d -exec sh -c "(echo {} && cd {} && git status && git fetch && echo;)" \;
end

alias github _github
alias gita 'git add .; git commit -m'
alias gitamend 'git add .; git commit --amend'
alias gitstash 'git add.; git stash'

# Remove all currently staged files (good for updating gitignore).
alias gitclear 'git rm -r --cached .'

# Remove all branches that are already in sync with origin master.
alias gitprune 'git remote prune origin'
# git branch --v | grep "\[gone\]" | awk '{print $1}' | xargs git branch -D

# Expects a directory name. Runs git status on that repo.
alias gitstatus _status

# Runs shortened git status on all repos in Github folder.
alias gitsummary _summary

# Gets number of lines in all files of a GitHub repo.
alias gitlines 'git ls-files | grep -Ev ".pdf|.png|.jpg" | xargs wc -l'

#########################
#   Directory Aliases   #
#########################

alias downloads 'cd ~/Downloads'
alias documents 'cd ~/Documents'
alias pictures 'cd ~/Pictures'

alias blog 'github blog'
alias wiki 'github wiki'
alias tyep 'github tyleryep.github.io'
alias wolf 'github wolfbot'
alias workshop 'github workshop'
alias myth 'ssh tyep@myth.stanford.edu'

alias planner 'open ~/Documents/Stanford_4_Year_Plan.xlsx'
alias resume 'open ~/Documents/TylerYep_2020.docx'

#########################
#       Robinhood       #
#########################

set EDITOR vim
set BASH_SILENCE_DEPRECATION_WARNING 1
set WORKON_HOME $HOME/.virtualenvs
bash /usr/local/bin/virtualenvwrapper.sh

function _export_django_settings_env
    if test $argv[1] = "brokeback"
        set DJANGO_SETTINGS_MODULE "settings.local.server"
    end
end

function _workon_cwd
    # Check that this is a Git repo
    set GIT_DIR (git rev-parse --git-dir 2> /dev/null)
    if test $status -eq 0
        # Find the repo root and check for virtualenv name override
        set GIT_DIR eval `\cd $GIT_DIR pwd`
        set PROJECT_ROOT `dirname "$GIT_DIR"`
        set PROJECT_NAME `basename "$PROJECT_ROOT"`
        # For rh repo, treat the current working directory as the project directory
        if test "$PROJECT_NAME" = "rh"
            set ENV_NAME "(basename) (pwd)"
        else
            set ENV_NAME "$PROJECT_NAME"
        end
        if [test -f "$PROJECT_ROOT/.venv"
            set ENV_NAME `cat "$PROJECT_ROOT/.venv"`
        end
        # Activate the environment only if it is not already active
        if test "$VIRTUAL_ENV" != "$WORKON_HOME/$ENV_NAME"
            if test -e "$WORKON_HOME/$ENV_NAME/bin/activate"
                workon "$ENV_NAME" && set CD_VIRTUAL_ENV="$ENV_NAME"
            end
            export_django_settings_env $ENV_NAME
        end
    else if $CD_VIRTUAL_ENV
        # We've just left the repo, deactivate the environment
        # Note: this only happens if the virtualenv was activated automatically
        deactivate && unset CD_VIRTUAL_ENV
    end
end

function _venv_cd
    cd $argv && _workon_cwd
end

alias arc '/Users/tyler.yep/robinhood/phabricator/arcanist/bin/arc'
# alias cd _venv_cd
alias clean_pyc "find . -name '*.pyc' -delete"
alias ad "arc diff --coverage --browse --skip-binaries"
alias submod "git submodule update --init --recursive"
alias submodpull "git submodule update --remote"

alias ut "DJANGO_SETTINGS_MODULE=settings.local.server REUSE_DB=true ./manage.py test --nologcapture --nocapture"
alias mut "DJANGO_SETTINGS_MODULE=settings.local.server REUSE_DB=false ./manage.py test --nologcapture --noinput --nocapture"
if not contains (pyenv root)/shims $PATH
    set PATH (pyenv root)/shims:$PATH
end

alias brokeback 'source ~/.virtualenvs/brokeback/bin/activate.fish'
alias bonfire 'source ~/.virtualenvs/bonfire/bin/activate.fish'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# eval /Users/tyleryep/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

# The next line updates PATH for the Google Cloud SDK.
# if [ -f '/Users/tyleryep/google-cloud-sdk/path.fish.inc' ]; . '/Users/tyleryep/google-cloud-sdk/path.fish.inc'; end
