#####################
#   Global Config   #
#####################
set EDITOR vim
set BASH_SILENCE_DEPRECATION_WARNING 1
set WORKON_HOME $HOME/.virtualenvs
bash /usr/local/bin/virtualenvwrapper.sh
set GITHUB_HOME ~/Documents/Github

#####################
#   Shell Aliases   #
#####################

alias fishedit 'code ~/.config/fish/config.fish'
alias .fish 'cd ~/.config/fish/'
alias history 'code ~/.local/share/fish/fish_history'
alias cd.. 'cd ..'
alias ccd 'cd'
alias filesize 'du -sh'
alias activ 'conda activate'
alias deac 'conda deactivate'
alias pylinta 'find . -iname "*.py" | xargs pylint'
alias jekyl 'bundle exec jekyll serve'
alias jup 'jupyter notebook'
alias pipbuild 'rm -r dist/; python setup.py sdist bdist_wheel; twine upload dist/*'
alias pipsize "pip list | tail -n +3 | awk '{print \$1}' | xargs pip show | \
    grep -E 'Location:|Name:' | cut -d ' ' -f 2 | paste -d ' ' - - | \
    awk '{print \$2 \"/\" tolower(\$1)}' | xargs du -sh 2> /dev/null"
alias workon _workon
alias workoff _workoff

function _workon
    source ~/.virtualenvs/$argv[1]/bin/activate.fish
end

function _workoff
    source ~/.virtualenvs/$argv[1]/bin/deactivate.fish
end

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
        cd $GITHUB_HOME
    else
        cd $GITHUB_HOME/$argv[1]
    end
end

function _status
    find $GITHUB_HOME/$argv[1] -name .git -execdir git status \;
end

function _summary
    find $GITHUB_HOME -maxdepth 1 -mindepth 1 -type d -exec sh -c \
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
        cd $GITHUB_HOME/workshop/explore
    else
        code $GITHUB_HOME/workshop/explore/$argv[1]
    end
end

#########################
#       Robinhood       #
#########################

if test -d /Users/tyler.yep/
    set RH_HOME ~/robinhood/rh
    alias arc '/Users/tyler.yep/robinhood/phabricator/arcanist/bin/arc'
    alias clean_pyc "find . -name '*.pyc' -delete"
    alias ad "arc diff --coverage --browse --skip-binaries"
    alias ut "DJANGO_SETTINGS_MODULE=settings.local.server REUSE_DB=true \
        ./manage.py test --nologcapture --nocapture"
    alias mut "DJANGO_SETTINGS_MODULE=settings.local.server REUSE_DB=false \
        ./manage.py test --nologcapture --noinput --nocapture"

    alias rh _rh
    alias brokeback 'cd ~/robinhood/rh/brokeback'
    alias bonfire 'cd ~/robinhood/rh/bonfire'
    alias sickle 'cd ~/robinhood/rh/sickle'
    alias web 'cd ~/robinhood/rh/web/web-app'
    alias testdata 'cd ~/robinhood/rh/home/client/src/projects/test-data-ui'

    function _rh
        if test -z $argv[1]
            cd $RH_HOME
        else
            cd $RH_HOME/$argv[1]
        end
    end

    alias ktunnel "ssh -N -L \
        9000:internal-api-rh-production-k8s-loc-qcce1d-31352784.us-east-1.elb.amazonaws.com:443 sm"
    alias kubeprod "kubectl config use-context production"
    alias kubedev "kubectl config use-context development"
    alias kubetest "kubectl config use-context test"
    alias kgp "kubectl get pods"
    alias klogs "kubectl logs -c app"
    alias ksh _ksh
    alias kkn _kkn

    function _ksh
        kubectl exec -it ($argv[1]) "bash"
    end

    function _kkn
        kubectl config set-context --current --namespace=$argv[1]
    end

    # function kshell
    #     set pod $(kubectl get pods --no-headers -o=custom-columns=NAME:.metadata.name | grep ^$1 | head -1)
    #     set container ""
    #     # [[ ! -z $2 ]] && set container "-c=$2"
    #     if [ ! -z $pod ]; then
    #         kubectl exec -it $pod $container -- /bin/sh -c "which /bin/bash >/dev/null && exec /bin/bash || exec /bin/sh"
    #     else
    #         echo "No pods matching \"$1\" were found in the current namespace: \"$(kubectl config view --minify --output 'jsonpath={..namespace}')\""
    #         return 1
    #     fi
    # end
end
