# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/tyler.yep/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#####################
#   Global Config   #
#####################
source ~/.git-prompt.sh
# Important: this needs to be single quotes
# Datetime: %W%t
eval "$(pyenv init -)"
export PS1='%B%F{blue}%n%F{cyan}:%~ %F{green}$(__git_ps1 "[%s] ")%F{red}❯%F{yellow}❯%F{green}❯%F{blue}%b%f '
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
alias brewupgrade="brew upgrade fish git pyenv sherwood"
function workon() { source ~/.virtualenvs/$1/bin/activate; }
alias workoff="deactivate"

##############
#   Github   #
##############

alias ghub='function _cd(){ cd ~/Documents/Github/$1 ; };_cd'
alias gita="git add -A; git commit -m"
alias gitamend="git add -A; git commit --amend"
alias gitstash="git add -A; git stash"
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
    set RH_HOME ~/robinhood/rh
    alias rh="cd ~/robinhood/rh"
    alias clean_pyc="find . -name '*.pyc' -delete"
    # alias ad="arc diff --coverage --browse --skip-binaries"
    alias ut="DJANGO_SETTINGS_MODULE=settings.local.server REUSE_DB=true \
        ./manage.py test --nologcapture --nocapture"
    alias mut="DJANGO_SETTINGS_MODULE=settings.local.server REUSE_DB=false \
        ./manage.py test --nologcapture --noinput --nocapture"

    alias web="cd $RH_HOME/web/web-app"
    alias testdata="cd $RH_HOME/home/client/src/projects/test-data-ui"
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
    ktxt() { kubectl config set-context --current --namespace=$1; }

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
