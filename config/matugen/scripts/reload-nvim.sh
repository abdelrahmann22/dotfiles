#!/bin/bash

# Reload Neovim colorscheme for LazyVim
# Create colors directory if it doesn't exist
mkdir -p ~/.config/nvim/colors

# Send reload signal to all running nvim instances
pkill -SIGUSR1 nvim 2>/dev/null || true

# Alternative: Use nvim remote if available
if command -v nvr &> /dev/null; then
    for server in ~/.cache/nvim/server-*; do
        if [ -S "$server" ]; then
            nvr --servername "$server" --remote-send "<Cmd>colorscheme matugen<CR>" 2>/dev/null || true
        fi
    done
fi

