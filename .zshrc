export PATH=/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export LSCOLORS="gxfxcxdxbxegedabagacad"

# Load plugins
source ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh

source ~/.zsh/history.zsh
source ~/.zsh/completions.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/functions.zsh
source ~/.zsh/async.zsh
source ~/.zsh/pure.zsh

# Make vim-like behaviour
bindkey -e

if command -v fasd >/dev/null 2>&1; then
  eval "$(fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install posix-alias)"
fi

# Load Brew Completions
#source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
#source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'

export PATH=$PATH:~/anaconda3/bin
export PATH=/opt/homebrew/opt/ruby/bin:$PATH

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/mseeler/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/mseeler/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/mseeler/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/mseeler/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# (cat ~/.cache/wal/sequences &)

export EDITOR=vim

source /Users/mseeler/.config/broot/launcher/bash/br
source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

export BAT_THEME="gruvbox"
export PIP2EVAL_TMP_FILE_PATH=/tmp/shms
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt/python@3.11/libexec/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Load Angular CLI autocompletion.
source <(ng completion script)

PATH=~/.console-ninja/.bin:$PATH