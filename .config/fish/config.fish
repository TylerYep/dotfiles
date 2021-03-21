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
source $HOME/.cargo/env
set GITHUB_HOME ~/Documents/Github

#####################
#   Shell Aliases   #
#####################

alias .. "cd .."
alias ... "cd ../.."
alias .... "cd ../../.."
alias ..... "cd ../../../.."
alias ...... "cd ../../../../.."
alias bashedit "code ~/.bashrc"
alias fishedit "code ~/.config/fish/config.fish"
alias fishconfig "cd ~/.config/fish/"
alias history "code ~/.local/share/fish/fish_history"
alias minecraft "open ~/Library/Application\ Support/minecraft/"
alias cd.. "cd .."
alias ccd "cd"
alias filesize "du -sh"
alias pylinta "find . -iname '*.py' | xargs pylint"
alias pyupgradea "find . -iname '*.py' | xargs pyupgrade"
alias pyup "git diff HEAD~1 HEAD --name-only | xargs pyupgrade --py310-plus"
alias pre "pre-commit run -a"
alias jekyl "bundle exec jekyll serve"
alias jup "jupyter notebook"
alias pipbuild "rm -r dist/; python setup.py sdist bdist_wheel; twine upload dist/*"
alias pipsize "pip list | tail -n +3 | awk '{print \$1}' | xargs pip show | \
    grep -E 'Location:|Name:' | cut -d ' ' -f 2 | paste -d ' ' - - | \
    awk '{print \$2 \"/\" tolower(\$1)}' | xargs du -sh 2> /dev/null"
alias pupgrade "pur -r requirements.txt; pur -r requirements-dev.txt"
alias nupgrade "ncu -u; npm-check -y"
alias brewupgrade "brew upgrade fish git pyenv sherwood"
alias workoff "deactivate"
alias activ workon
alias deac workoff

function journal
    if test -z $argv[1]
        set folder $GITHUB_HOME/wiki/blog/(date +%Y-%m)
        set output $folder/(date +%F).md
        # If file already exists, just open the file
        if test ! -s $output
            # Else create the folder and file if necessary
            if test -d $folder
                touch $output
            else
                mkdir $folder
            end
            echo -e >$output "---\ntitle: "(date +%D)"\ntags: [robinhood]\n---"
        end
        code $output
    else
        set folder (string split - $argv[1])[1]
        code $GITHUB_HOME/wiki/blog/2020-$folder/2020-$argv[1].md
    end
end

function workon
    if test -z $argv[1]
        ls -F ~/.virtualenvs/ | grep / | sed 's/\/$//'
    else
        source ~/.virtualenvs/$argv[1]/bin/activate.fish
    end
end

function diff_dirs
    diff <(cd $argv[1] && find | sort) <(cd $argv[2] && find | sort)
end

##############
#   Github   #
##############

alias gita "git add -A; git commit -m"
alias gitamend "git add -A; git commit --amend"
alias gitstash "git add -A; git stash"
alias gitupstream "git branch --set-upstream-to=origin/master"

# Remove all currently staged files (good for updating gitignore).
alias gitclear "git rm -r --cached ."

# Remove all branches that are already in sync with origin master.
alias gitprune "git remote prune origin"
# git branch --v | grep "\[gone\]" | awk "{print $1}" | xargs git branch -D

# Gets number of lines in all files of a GitHub repo.
alias gitlines "git ls-files | grep -Ev '.pdf|.png|.jpg' | xargs wc -l"

function ghub
    if test -z $argv[1]
        cd $GITHUB_HOME
    else
        cd $GITHUB_HOME/$argv[1]
    end
end

# Expects a directory name. Runs git status on that repo.
function gitstatus
    find $GITHUB_HOME/$argv[1] -name .git -execdir git status \;
end

# Runs shortened git status on all repos in Github folder.
function gitsummary
    find $GITHUB_HOME -maxdepth 1 -mindepth 1 -type d -exec sh -c \
        "(echo {} && cd {} && git status && git fetch && echo;)" \;
end

#########################
#   Directory Aliases   #
#########################

alias desktop "cd ~/Desktop"
alias downloads "cd ~/Downloads"
alias documents "cd ~/Documents"
alias pictures "cd ~/Pictures"
alias planner "open ~/Documents/Stanford_4_Year_Plan.xlsx"
alias resume "open ~/Documents/TylerYep_2020.docx"

alias blog "ghub blog"
alias wiki "ghub wiki"
alias tyep "ghub tyleryep.github.io"
alias wolf "ghub wolfbot"
alias workshop "ghub workshop"

function explore
    if test -z $argv[1]
        cd $GITHUB_HOME/workshop/explore
    else
        code $GITHUB_HOME/workshop/explore/$argv[1].py
    end
end

#########################
#       Robinhood       #
#########################

if test -d /Users/tyler.yep/
    set RH_HOME ~/robinhood/rh
    alias clean_pyc "find . -name '*.pyc' -delete"
    # alias ad "arc diff --coverage --browse --skip-binaries"
    alias ut "DJANGO_SETTINGS_MODULE=settings.local.server REUSE_DB=true \
        ./manage.py test --nologcapture --nocapture"
    alias mut "DJANGO_SETTINGS_MODULE=settings.local.server REUSE_DB=false \
        ./manage.py test --nologcapture --noinput --nocapture"

    alias web "rh web/web-app"
    alias testdata "rh home/client/src/projects/test-data-ui"
    alias rdt "cd ~/robinhood/robinhood-deploy-tools"

    function rh
        if test -z $argv[1]
            cd $RH_HOME
        else
            cd $RH_HOME/$argv[1]
        end
    end

    alias k "kubectl"
    alias ktunnel "ssh -N -L \
        9000:internal-api-rh-production-k8s-loc-qcce1d-31352784.us-east-1.elb.amazonaws.com:443 sm"
    alias ktunnel1 "ssh -N -L \
        9001:internal-api-rh-production-1-k8s-l-vqhams-358126698.us-east-1.elb.amazonaws.com:443 sm"
    alias ktunnel2 "ssh -N -L \
        9003:internal-api-rh-production-2-k8s-l-3fqh39-928912726.us-east-1.elb.amazonaws.com:443 sm"

    alias knamespace "kubectl --context rh-production.k8s.local -v=8 get namespaces"
    alias knamespace1 "kubectl --context rh-production-1.k8s.local -v=8 get namespaces"
    alias knamespace2 "kubectl --context rh-production-2.k8s.local -v=8 get namespaces"

    alias kdev "kubectl config use-context development"
    alias kprod "kubectl config use-context production"
    alias ktest "kubectl config use-context test"
    alias kls "kubectl config view --minify --output 'jsonpath={..namespace}'"
    alias kpods "kubectl get pods"
    alias klogs "kubectl logs -c app"

    function ksh
        # SSH into the pod matching name exactly
        kubectl exec -it $argv[1] bash
    end

    function ktxt
        # Expects the full name, e.g. brokeback-us-1 or discovery
        kubectl config set-context --current --namespace=$argv[1]
    end

    function kshell
        # SSH into the pod matching grep'ed name
        set pod (kubectl get pods --no-headers -o=custom-columns=NAME:.metadata.name \
            | grep $argv[1] | head -1)
        set container ""
        if test -z $argv[2]
            set container -c=$argv[2]
        end
        if test -z $pod
            echo "No matching pods were found in the current namespace: "(kls)
            return 1
        else
            kubectl exec -it $pod $container -- /bin/sh -c \
                "which /bin/bash >/dev/null && exec /bin/bash || exec /bin/sh"
        end
    end

    set -x LDFLAGS "-L(brew --prefix openssl@1.1)/lib"
    set -x CFLAGS "-I(brew --prefix openssl@1.1)/include"
end
