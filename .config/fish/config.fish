#####################
#   Shell Aliases   #
#####################

alias fishedit 'vim ~/.config/fish/config.fish'
alias .fish 'cd ~/.config/fish/'
alias python '/Users/tyleryep/miniconda3/bin/python3.7'
alias cd.. 'cd ..'
alias ccd 'cd'
alias filesize 'du -sh'
alias activ 'conda activate'
alias deac 'conda deactivate'
alias pylinta 'find . -iname "*.py" | xargs pylint'
alias jekyl 'bundle exec jekyll serve'
alias jup 'jupyter notebook'
alias pipbuild 'rm -r dist/; python setup.py sdist bdist_wheel; twine upload dist/*'

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

# Remove all currently staged files (good for updating gitignore).
alias gitclear 'git rm -r --cached .'

# Remove all branches that are already in sync with origin master.
alias gitprune 'git remote prune origin'
# git branch --v | grep "\[gone\]" | awk '{print $1}' | xargs git branch -D

# Expects a directory name. Runs git status on that repo.
alias gitstatus _status

# Runs shortened git status on all repos in Github folder.
alias gitsummary _summary

#########################
#   Directory Aliases   #
#########################

alias downloads 'cd ~/Downloads'
alias documents 'cd ~/Documents'
alias pictures 'cd ~/Pictures'

alias blog 'github blog'
alias front 'github bluepress2-frontend'
alias back 'github bluepress2-backend'
alias wiki 'github wiki'
alias tyep 'github tyleryep.github.io'
alias wolf 'github wolfbot'
alias toolkit 'github ai-toolkit'
alias torchsummary 'github torch-summary'

alias myth 'ssh tyep@myth.stanford.edu'
alias cardinal 'ssh tyep@cardinal.stanford.edu'

alias planner 'open ~/Documents/Stanford_4_Year_Plan.xlsx'
alias resume 'open ~/Documents/TylerYep_2019.docx'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /Users/tyleryep/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/tyleryep/google-cloud-sdk/path.fish.inc' ]; . '/Users/tyleryep/google-cloud-sdk/path.fish.inc'; end
