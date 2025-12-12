#!/bin/bash

# Setup btop to use matugen theme automatically

BTOP_CONF="$HOME/.config/btop/btop.conf"

if [ -f "$BTOP_CONF" ]; then
    # Update existing config to use matugen theme
    if grep -q "^color_theme" "$BTOP_CONF"; then
        sed -i 's/^color_theme.*/color_theme = "matugen"/' "$BTOP_CONF"
        echo "Updated btop to use matugen theme"
    else
        echo 'color_theme = "matugen"' >> "$BTOP_CONF"
        echo "Added matugen theme to btop config"
    fi
else
    # Create btop config with matugen theme
    mkdir -p ~/.config/btop/themes
    cat > "$BTOP_CONF" << 'EOF'
# Btop theme
color_theme = "matugen"
EOF
    echo "Created btop config with matugen theme"
fi

# Send signal to reload btop if it's running
pkill -SIGUSR1 btop 2>/dev/null || true

