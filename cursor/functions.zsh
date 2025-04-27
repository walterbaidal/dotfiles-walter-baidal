#!/bin/bash

savecursor() {
  local plugin="$1"
  local plugin_dir="$HOME/$plugin"
  local cursor_user_dir="$plugin_dir/cursor/User"
  local source_dir="$HOME/Library/Application Support/Cursor/User"
  local dest_dir="$plugin_dir/cursor"
  local key_file="keybindings.json"
  local settings_file="settings.json"

  if [[ -z "$plugin" ]]; then
    echo "❌ Please provide the plugin name (a folder inside \$HOME)."
    return 1
  fi

  if [[ ! -d "$plugin_dir" ]]; then
    echo "❌ Plugin '$plugin' not found in \$HOME."
    return 1
  fi

  mkdir -p "$cursor_user_dir"

  for file in "$key_file" "$settings_file"; do
    local src="$source_dir/$file"
    local dest="$cursor_user_dir/$file"
    
    if [[ -f "$src" ]]; then
      if [[ -f "$dest" ]] && ! cmp -s "$src" "$dest"; then
        echo "🔁 $file already exists and is different. Creating backup copy..."
        cp "$dest" "$dest.copy"
      fi
      cp "$src" "$dest"
      echo "✅ Copied $file to $cursor_user_dir"
    else
      echo "⚠️  $file not found in $source_dir"
    fi
  done

  mkdir -p "$dest_dir"

  local extensions_file="$dest_dir/extensions-list.txt"
  if cursor --list-extensions > "$extensions_file"; then
    echo "✅ Extensions list saved to $extensions_file"
  else
    echo "❌ 'cursor --list-extensions' failed."
    echo "⚠️  Configuration files were copied, but the extensions list could not be generated."
    echo "🔧 Please check the command and re-run the function manually."
    return 1
  fi
}
