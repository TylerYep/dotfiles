# \h is hostname, \W is pwd, then the git branch
source ~/.git-prompt.sh
export PS1='\h:\W $(__git_ps1 '[%s]')$ '

# Use $1 to pass arguments into a command e.g. 'find ~/Documents/Github/$1'
alias aliasedit='vim ~/.bashrc'
alias fishconfig='vim ~/.config/fish/config.fish'
alias cd..='cd ..'
alias activ='conda activate'
alias deac='conda deactivate'
alias pylinta='find . -iname "*.py" | xargs pylint'
alias filesize='du -sh'

alias jekyl='bundle exec jekyll serve'

alias github='function _cd(){ cd ~/Documents/Github/$1 ; };_cd'
alias gita='git add .; git commit -m'
alias gitrb='git rebase -i HEAD~2'

# Remove all currently staged files (good for updating gitignore)
alias gitclear='git rm -r --cached .'

# Remove all branches that are already in sync with origin master 
alias gitprune='git remote prune origin'
alias gitstatus='function _status(){ find ~/Documents/Github/$1 -name .git -execdir git status \; ; };_status'
alias gitsummary='function _gitsumm(){ find ~/Documents/Github/ -maxdepth 1 -mindepth 1 -type d -exec sh -c "(echo {} && cd {} && git status -s && git fetch && echo;)" \;  ; };_gitsumm'

alias downloads='cd ~/Downloads'
alias documents='cd ~/Documents'
alias pictures='cd ~/Pictures'

alias blog='github blog'
alias cs231n='github stanford-cs231n'
alias front='github bluepress2-frontend'
alias back='github bluepress2-backend'
alias jup='jupyter notebook'

alias myth='ssh tyep@myth.stanford.edu'
alias cardinal='ssh tyep@cardinal.stanford.edu'

alias wiki='cd ~/Documents/Github/wiki'
alias tyep='cd ~/Documents/Github/tyleryep.github.io'
alias wolf='cd ~/Documents/Github/wolfbot'

alias planner='open ~/Documents/Stanford_4_Year_Plan.xlsx'
alias resume='open ~/Documents/TylerYep_2019.docx'
