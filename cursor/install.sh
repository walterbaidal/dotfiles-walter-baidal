# Link Cursor settings
CURSOR_USER_PATH="$HOME/Library/Application Support/Cursor/User"
DOTFILES_CURSOR_USER_PATH="$HOME/.dotfiles/plugins/dotfiles-walter-baidal/cursor/User"
SETTINGS_FILENAME="settings.json"
KEYBINDINGS_FILENAME="keybindings.json"

# Create the directory if it doesn't exist
mkdir -p "$CURSOR_USER_PATH"

# Remove the application files if they exist
rm -rf "$CURSOR_USER_PATH/${SETTINGS_FILENAME}"
rm -rf "$CURSOR_USER_PATH/${KEYBINDINGS_FILENAME}"

# Link files
ln -s $DOTFILES_CURSOR_USER_PATH/${SETTINGS_FILENAME} "$CURSOR_USER_PATH/${SETTINGS_FILENAME}"
ln -s $DOTFILES_CURSOR_USER_PATH/${KEYBINDINGS_FILENAME} "$CURSOR_USER_PATH/${KEYBINDINGS_FILENAME}"

# Install Cursor extensions from extensions-list.txt
EXTENSIONS_LIST_PATH="$HOME/.dotfiles/plugins/dotfiles-walter-baidal/cursor/extensions-list.txt"
FAILED_EXTENSIONS=()

if [[ ! -f "$EXTENSIONS_LIST_PATH" ]]; then
  echo "❌ Extensions list not found at $EXTENSIONS_LIST_PATH"
else
  echo "📦 Installing Cursor extensions..."
  while IFS= read -r extension; do
    if [[ -z "$extension" ]]; then
      continue
    fi

    if cursor --list-extensions | grep -q "^$extension$"; then
      echo "✅ Extension already installed: $extension"
    else
      echo "📥 Installing: $extension"
      if cursor --install-extension "$extension"; then
        echo "✅ Installed: $extension"
      else
        echo "❌ Failed to install: $extension"
        FAILED_EXTENSIONS+=("$extension")
      fi
    fi
  done < "$EXTENSIONS_LIST_PATH"

  # Summary of failed installs
  if [[ ${#FAILED_EXTENSIONS[@]} -gt 0 ]]; then
    echo ""
    echo "⚠️  The following extensions failed to install:"
    for ext in "${FAILED_EXTENSIONS[@]}"; do
      echo "  - $ext"
    done
    echo "🔧 Please review these manually."
  else
    echo "🎉 All extensions installed successfully."
  fi
fi
