install_oh_my_zsh() {
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    blue "[OS] Installing Oh-My-Zsh"

    if [ "$(uname)" = "Darwin" ] || [ "$(uname -s | cut -c1-5)" = "Linux" ]; then
      RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi
  else
    green "[OS] Oh-My-Zsh is already installed"
  fi
}
