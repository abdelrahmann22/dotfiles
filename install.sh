#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_SRC="$DOTFILES_DIR/config"
CONFIG_DEST="$HOME/.config"
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

backup_and_link() {
    local src="$1"
    local dest="$2"
    local name="$3"

    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        if [ "$backup_created" = false ]; then
            mkdir -p "$BACKUP_DIR"
            backup_created=true
            log_info "Backup directory created at $BACKUP_DIR"
        fi
        log_warn "Backing up existing $dest"
        mv "$dest" "$BACKUP_DIR/"
    elif [ -L "$dest" ]; then
        log_warn "Removing existing symlink $dest"
        rm "$dest"
    fi

    ln -s "$src" "$dest"
    log_info "Linked $name"
}

backup_created=false

# Create config directory if it doesn't exist
mkdir -p "$CONFIG_DEST"

# Config directories to link
configs=(
    "cava"
    "fastfetch"
    "hypr"
    "kanshi"
    "kitty"
    "mako"
    "matugen"
    "nvim"
    "rofi"
    "waybar"
    "waypaper"
)

# Link config directories
for dir_name in "${configs[@]}"; do
    src="$CONFIG_SRC/$dir_name"
    dest="$CONFIG_DEST/$dir_name"
    if [ -d "$src" ]; then
        backup_and_link "$src" "$dest" "$dir_name"
    else
        log_warn "Config directory $dir_name not found, skipping"
    fi
done

# Link wallpapers directory if it exists
if [ -d "$DOTFILES_DIR/wallpapers" ]; then
    backup_and_link "$DOTFILES_DIR/wallpapers" "$HOME/wallpapers" "wallpapers"
fi

echo ""
log_info "Dotfiles installation complete!"
if [ "$backup_created" = true ]; then
    log_info "Existing configs backed up to: $BACKUP_DIR"
fi

# Dependencies note
echo ""
log_info "Required packages:"
echo "  - hyprland, hyprpaper, hypridle, hyprlock"
echo "  - waybar, mako"
echo "  - rofi, kitty"
echo "  - cava, fastfetch"
echo "  - kanshi"
echo "  - matugen"
echo "  - cliphist (go install go.senan.xyz/cliphist@latest)"
echo "  - waypaper"
