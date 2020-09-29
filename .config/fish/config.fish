#####################
#   Global Config   #
#####################
set EDITOR vim
set BASH_SILENCE_DEPRECATION_WARNING 1
set WORKON_HOME $HOME/.virtualenvs
if not contains (pyenv root)/shims $PATH
    set PATH (pyenv root)/shims:$PATH
end
bash /usr/local/bin/virtualenvwrapper.sh

#####################
#   Shell Aliases   #
#####################

alias fishedit 'code ~/.config/fish/config.fish'
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

alias github _github
alias gita 'git add .; git commit -m'
alias gitamend 'git add .; git commit --amend'
alias gitstash 'git add .; git stash'

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
    find ~/Documents/Github/ -maxdepth 1 -mindepth 1 -type d -exec sh -c \
        "(echo {} && cd {} && git status && git fetch && echo;)" \;
end

#########################
#   Directory Aliases   #
#########################

alias downloads 'cd ~/Downloads'
alias documents 'cd ~/Documents'
alias pictures 'cd ~/Pictures'
alias planner 'open ~/Documents/Stanford_4_Year_Plan.xlsx'
alias resume 'open ~/Documents/TylerYep_2020.docx'

alias blog 'github blog'
alias wiki 'github wiki'
alias tyep 'github tyleryep.github.io'
alias wolf 'github wolfbot'
alias workshop 'github workshop'
alias explore _explore

function _explore
    if test -z $argv[1]
        cd ~/Documents/Github/workshop/explore
    else
        code ~/Documents/Github/workshop/explore/$argv[1]
    end
end

#########################
#       Robinhood       #
#########################

if test -d /Users/tyler.yep/
    alias arc '/Users/tyler.yep/robinhood/phabricator/arcanist/bin/arc'
    alias clean_pyc "find . -name '*.pyc' -delete"
    alias ad "arc diff --coverage --browse --skip-binaries"
    alias ut "DJANGO_SETTINGS_MODULE=settings.local.server REUSE_DB=true \
        ./manage.py test --nologcapture --nocapture"
    alias mut "DJANGO_SETTINGS_MODULE=settings.local.server REUSE_DB=false \
        ./manage.py test --nologcapture --noinput --nocapture"
    alias brokeback 'source ~/.virtualenvs/brokeback/bin/activate.fish'
    alias bonfire 'source ~/.virtualenvs/bonfire/bin/activate.fish'
end

set -g fish_user_paths "/usr/local/opt/tcl-tk/bin" $fish_user_paths
