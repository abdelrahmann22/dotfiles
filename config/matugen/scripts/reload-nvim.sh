#!/bin/bash

# Reload Neovim colorscheme for LazyVim
# Create colors directory if it doesn't exist
mkdir -p ~/.config/nvim/colors

# Send reload signal to all running nvim instances
pkill -SIGUSR1 nvim 2>/dev/null || true
