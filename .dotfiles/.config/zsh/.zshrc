export ZSH="$HOME/.config/zsh/.oh-my-zsh"
ZSH_THEME="alanpeabody"

plugins=(git zsh-syntax-highlighting zsh-autosuggestions zsh-history-substring-search zsh-z)
source $ZSH/oh-my-zsh.sh

export PATH="$HOME/.config/emacs/bin":$PATH


source "$HOME/.config/shell/aliasrc"
source "$HOME/.zprofile"
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
