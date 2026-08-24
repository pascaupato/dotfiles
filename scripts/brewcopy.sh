#!/bin/bash

# Brewfile and leaves
cd "$DOTFILES/homebrew" || exit 1
brew bundle dump --force
brew leaves > leaves.txt
