export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="miloshadzic"

plugins=(git)

source $ZSH/oh-my-zsh.sh
source $HOME/.bash_aliases
source $HOME/dotfiles/functions

alias myzsh="vi ~/.zshrc"
alias myvim="vi ~/dotfiles/vimrc"
alias alia="vi ~/.bash_aliases"

alias vis="source ~/.vimrc"
alias zshs="source ~/.zshrc"
alias bas="source ~/.bash_aliases"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ruimangas/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/ruimangas/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ruimangas/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/ruimangas/google-cloud-sdk/completion.zsh.inc'; fi
