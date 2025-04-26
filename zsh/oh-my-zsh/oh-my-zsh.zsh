export ZSH=$HOME/.oh-my-zsh
export ZSH_DISABLE_COMPFIX="true"

ZSH_THEME=""
# ZSH_THEME="powerlevel10k/powerlevel10k"
HIST_STAMPS="dd.mm.yyyy"
plugins=(z git zsh-autosuggestions zsh-syntax-highlighting)

# If Homebrew is installed under /opt/homebrew folder
if [ -f /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

source $ZSH/oh-my-zsh.sh
