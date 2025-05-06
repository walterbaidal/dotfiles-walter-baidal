#!/bin/bash

set -euo pipefail

if [ -f /usr/local/bin/devbox ]; then
  rm /usr/local/bin/devbox
fi

if [ -d ~/.cache/devbox ]; then
  rm -rf ~/.cache/devbox
fi

if [ -d ~/.local/share/devbox ]; then
  rm -rf ~/.local/share/devbox
fi
