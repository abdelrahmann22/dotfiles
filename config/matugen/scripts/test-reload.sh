#!/bin/bash

# Test script to verify matugen auto-reload setup

echo "=== Matugen Auto-Reload Test ==="
echo ""

# Check if matugen is installed
if command -v matugen &> /dev/null; then
    echo "✓ matugen is installed"
else
    echo "✗ matugen not found"
    exit 1
fi

# Check templates
echo ""
echo "Checking templates..."
for template in btop.theme nvim-lazyvim.lua tty-clock-wrapper.sh; do
    if [ -f ~/.config/matugen/templates/$template ]; then
        echo "  ✓ $template"
    else
        echo "  ✗ $template missing"
    fi
done

# Check scripts
echo ""
echo "Checking scripts..."
for script in apply-wallpaper.sh reload-apps.sh reload-nvim.sh; do
    if [ -x ~/.config/matugen/scripts/$script ]; then
        echo "  ✓ $script (executable)"
    else
        echo "  ✗ $script (missing or not executable)"
    fi
done

# Check running applications
echo ""
echo "Checking running applications..."
for app in kitty btop nvim waybar; do
    if pgrep -x $app > /dev/null; then
        echo "  ✓ $app is running (can be reloaded)"
    else
        echo "  - $app not running"
    fi
done

# Check nvim setup
echo ""
echo "Checking Neovim setup..."
if [ -f ~/.config/nvim/lua/plugins/matugen.lua ]; then
    echo "  ✓ LazyVim plugin installed"
else
    echo "  ✗ LazyVim plugin not found"
fi

if [ -d ~/.config/nvim/colors ]; then
    echo "  ✓ colors directory exists"
else
    echo "  - colors directory will be created"
fi

# Check btop config
echo ""
echo "Checking btop configuration..."
if [ -f ~/.config/btop/btop.conf ]; then
    if grep -q "matugen" ~/.config/btop/btop.conf; then
        echo "  ✓ btop configured to use matugen theme"
    else
        echo "  - btop not configured, run: ~/.config/matugen/scripts/setup-btop-theme.sh"
    fi
else
    echo "  - btop config not found"
fi

# Check tty-clock
echo ""
echo "Checking tty-clock..."
if command -v tty-clock &> /dev/null; then
    echo "  ✓ tty-clock is installed"
    if [ -f ~/.local/bin/tty-clock-themed ]; then
        echo "  ✓ themed wrapper available"
    else
        echo "  - themed wrapper will be created after running matugen"
    fi
else
    echo "  - tty-clock not installed"
fi

echo ""
echo "=== Test Complete ==="
echo ""
echo "To test the full pipeline:"
echo "  1. Run: ~/.config/matugen/scripts/apply-wallpaper.sh ~/path/to/image.jpg"
echo "  2. Or: Select a wallpaper in waypaper"
echo ""
echo "Applications will reload silently in the background."

