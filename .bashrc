#####################
#   Global Config   #
#####################
# \u is user, \h is hostname, \w is pwd, then the git branch
# \[\e]0;\u: \w\a\] sets the title bar
# Bash Colors: https://misc.flogisoft.com/bash/tip_colors_and_formatting
source ~/.git-prompt.sh
# Important: this needs to be single quotes
export PS1='\[\e]0;\u: \w\a\]\e[1m\e[34m\u\e[36m:\w \e[32m$(__git_ps1 "[%s] ")\e[35m❯\e[36m❯\e[32m❯\e[39m\e[0m '
export EDITOR=vim
export BASH_SILENCE_DEPRECATION_WARNING=1
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
# if not contains (pyenv root)/shims $PATH
#     set PATH (pyenv root)/shims:$PATH
# end
# source $HOME/.cargo/env
# set GITHUB_HOME ~/Documents/Github

#####################
#   Shell Aliases   #
#####################

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias bashedit="code ~/.bashrc"
alias fishedit="code ~/.config/fish/config.fish"
alias fishconfig="cd ~/.config/fish/"
alias history="code ~/.local/share/fish/fish_history"
alias cd..="cd .."
alias ccd="cd"
alias filesize="du -sh"
alias pylinta="find . -iname '*.py' | xargs pylint"
alias pyupgradea="find . -iname '*.py' | xargs pyupgrade"
alias pre="pre-commit run -a"
alias jekyl="bundle exec jekyll serve"
alias jup="jupyter notebook"
alias pipbuild="rm -r dist/; python setup.py sdist bdist_wheel; twine upload dist/*"
alias pipsize="pip list | tail -n +3 | awk '{print \$1}' | xargs pip show | \
    grep -E 'Location:|Name:' | cut -d ' ' -f 2 | paste -d ' ' - - | \
    awk '{print \$2 \"/\" tolower(\$1)}' | xargs du -sh 2> /dev/null"
alias pupgrade="pur -r requirements.txt; pur -r requirements-dev.txt"
alias nupgrade="ncu -u; npm-check -y"
function workon() { source ~/.virtualenvs/$1/bin/activate; }
alias workoff="deactivate"

##############
#   Github   #
##############

alias ghub='function _cd(){ cd ~/Documents/Github/$1 ; };_cd'
alias gita="git add .; git commit -m"
alias gitamend="git add .; git commit --amend"
alias gitstash="git add .; git stash"
alias gitupstream="git branch --set-upstream-to=origin/master"
alias gitrb='git rebase -i HEAD~2'

# Remove all currently staged files (good for updating gitignore).
alias gitclear="git rm -r --cached ."

# Remove all branches that are already in sync with origin master.
alias gitprune="git remote prune origin"
# git branch --v | grep "\[gone\]" | awk "{print $1}" | xargs git branch -D

# Gets number of lines in all files of a GitHub repo.
alias gitlines="git ls-files | grep -Ev '.pdf|.png|.jpg' | xargs wc -l"
alias gitstatus='function _status(){ find ~/Documents/Github/$1 -name .git -execdir git status \; ; };_status'
alias gitsummary='function _gitsumm(){ find ~/Documents/Github/ -maxdepth 1 -mindepth 1 -type d -exec sh -c "(echo {} && cd {} && git status -s && git fetch && echo;)" \;  ; };_gitsumm'
alias gitlog='git log --graph --pretty="tformat:%C(yellow)%h%Creset %Cgreen(%ar)%Creset %C(bold blue)<%an>%Creset %C(red)%d%Creset %s" --all'

#########################
#   Directory Aliases   #
#########################

alias desktop="cd ~/Desktop"
alias downloads="cd ~/Downloads"
alias documents="cd ~/Documents"
alias pictures="cd ~/Pictures"
alias planner="open ~/Documents/Stanford_4_Year_Plan.xlsx"
alias resume="open ~/Documents/TylerYep_2020.docx"

alias blog="ghub blog"
alias wiki="ghub wiki"
alias tyep="ghub tyleryep.github.io"
alias wolf="ghub wolfbot"
alias workshop="ghub workshop"

#########################
#       Robinhood       #
#########################

if [[ -d /Users/tyler.yep/ ]]; then
    # set RH_HOME ~/robinhood/rh
    alias rh="cd ~/robinhood/rh"
    alias clean_pyc="find . -name '*.pyc' -delete"
    # alias ad="arc diff --coverage --browse --skip-binaries"
    alias ut="DJANGO_SETTINGS_MODULE=settings.local.server REUSE_DB=true \
        ./manage.py test --nologcapture --nocapture"
    alias mut="DJANGO_SETTINGS_MODULE=settings.local.server REUSE_DB=false \
        ./manage.py test --nologcapture --noinput --nocapture"

    alias web="rh web/web-app"
    alias testdata="rh home/client/src/projects/test-data-ui"
    alias rdt="cd ~/robinhood/robinhood-deploy-tools"

    alias ktunnel="ssh -N -L \
        9000:internal-api-rh-production-k8s-loc-qcce1d-31352784.us-east-1.elb.amazonaws.com:443 sm"
    alias kubedev="kubectl config use-context development"
    alias kubeprod="kubectl config use-context production"
    alias kubetest="kubectl config use-context test"
    alias kls="kubectl config view --minify --output 'jsonpath={..namespace}'"
    alias kpods="kubectl get pods"
    alias klogs="kubectl logs -c app"
    ksh() { kubectl exec -it "$1" "bash"; }
    ktxt() { kubectl config set-context --current --namespace=brokeback-us-$1; }

    function kshell() {
        pod = $(kubectl get pods --no-headers -o=custom-columns=NAME:.metadata.name | grep ^$1 | head -1)
        container = ""
        [[ ! -z $2 ]] && container = "-c=$2"
        if [ -z $pod ]; then
            echo "No pods matching \"$1\" were found in the current namespace: \"$(kls)\""
            return 1
        else
            kubectl exec -it $pod $container -- /bin/sh -c "which /bin/bash >/dev/null && exec /bin/bash || exec /bin/sh"
        fi
    }

    # set -x LDFLAGS "-L(brew --prefix openssl@1.1)/lib"
    # set -x CFLAGS "-I(brew --prefix openssl@1.1)/include"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
