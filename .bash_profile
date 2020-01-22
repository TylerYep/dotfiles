source ~/.bashrc

# added by Miniconda3 installer
# export PATH="/Users/tyleryep/miniconda3/bin:$PATH"  # commented out by conda initialize

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/tyleryep/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/tyleryep/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/tyleryep/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/tyleryep/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/tyleryep/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/Users/tyleryep/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/tyleryep/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/tyleryep/Downloads/google-cloud-sdk/completion.bash.inc'; fi

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/opt/llvm/bin:$PATH"
