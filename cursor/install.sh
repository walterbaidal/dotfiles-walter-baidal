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

# Synchronize Cursor config files from plugin if needed
for file in "$SETTINGS_FILENAME" "$KEYBINDINGS_FILENAME"; do
  src="$DOTFILES_CURSOR_USER_PATH/$file"
  dest="$CURSOR_USER_PATH/$file"

  if [[ ! -f "$src" ]]; then
    echo "⚠️  Plugin file not found: $src"
    continue
  fi

  if [[ -f "$dest" ]]; then
    if cmp -s "$src" "$dest"; then
      echo "✅ $file is already up-to-date. No action needed."
      continue
    fi

    cp "$dest" "$dest.backup"
    echo "📝 Existing $file backed up → $file.backup"
  fi

  cp "$src" "$dest"
  echo "✅ Synced $file from plugin to Cursor config"
done

echo "🎯 Cursor settings are now synchronized with your plugin."


# Install Cursor extensions from extensions-list.txt
EXTENSIONS_LIST_PATH="$HOME/.dotfiles/plugins/dotfiles-walter-baidal/cursor/extensions-list.txt"
FAILED_EXTENSIONS=()

if [[ ! -f "$EXTENSIONS_LIST_PATH" ]]; then
  echo "❌ Extensions list not found at $EXTENSIONS_LIST_PATH"
else
  echo "📦 Installing Cursor extensions..."
  while IFS= read -r extension; do
    # Skip empty lines
    if [[ -z "$extension" ]]; then
      continue
    fi

    # Check if extension is already installed (case-insensitive match)
    if cursor --list-extensions | grep -i -q "^$extension$"; then
      echo "✅ Extension already installed: $extension"
      continue
    fi

    # Try to install the extension
    echo "📥 Installing: $extension"
    output=$(cursor --install-extension "$extension" 2>&1)

    if echo "$output" | grep -q "already installed"; then
      echo "✅ Skipped (already installed): $extension"
    elif [[ $? -eq 0 ]]; then
      echo "✅ Installed: $extension"
    else
      echo "❌ Failed to install: $extension"
      echo "$output"
      FAILED_EXTENSIONS+=("$extension")
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
