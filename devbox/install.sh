#!/bin/bash

if ! command -v devbox >/dev/null 2>&1; then
    curl -fsSL https://get.jetify.com/devbox | bash -s -- --force
fi