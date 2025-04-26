export ZSH=$HOME/.oh-my-zsh
export ZSH_DISABLE_COMPFIX="true"

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_THEME="powerlevel10k/powerlevel10k"
HIST_STAMPS="dd.mm.yyyy"
plugins=(z git zsh-autosuggestions zsh-syntax-highlighting)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# If Homebrew is installed under /opt/homebrew folder
if [ -f /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

source $ZSH/oh-my-zsh.sh
