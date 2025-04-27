#!/bin/bash

if [ ! -f $HOME/.fzf.zsh ]; then 
  printf "y\ny\nn\n" | $(brew --prefix)/opt/fzf/install
fi