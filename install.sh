#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_SRC="$DOTFILES_DIR/config"
CONFIG_DEST="$HOME/.config"
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
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

log_section() {
    echo ""
    echo -e "${BLUE}==>${NC} $1"
}

# Detect package manager and OS
detect_system() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$ID
        OS_VERSION=$VERSION_ID
    else
        log_error "Cannot detect OS. /etc/os-release not found."
        exit 1
    fi

    if command -v dnf &> /dev/null; then
        PKG_MANAGER="dnf"
    elif command -v apt &> /dev/null; then
        PKG_MANAGER="apt"
    elif command -v pacman &> /dev/null; then
        PKG_MANAGER="pacman"
    else
        log_error "Unsupported package manager. This script supports dnf, apt, and pacman."
        exit 1
    fi

    log_info "Detected OS: $OS $OS_VERSION"
    log_info "Package manager: $PKG_MANAGER"
}

# Install packages
install_packages() {
    log_section "Installing required packages"

    case $PKG_MANAGER in
        dnf)
            # Check if Fedora
            if [ "$OS" != "fedora" ]; then
                log_warn "This script is optimized for Fedora. Proceeding anyway..."
            fi

            # Enable solopasha/hyprland COPR for Hyprland ecosystem
            if ! dnf copr list --enabled 2>/dev/null | grep -q "solopasha/hyprland"; then
                log_info "Enabling solopasha/hyprland COPR repository..."
                sudo dnf copr enable -y solopasha/hyprland || log_error "Failed to enable COPR"
            else
                log_info "solopasha/hyprland COPR already enabled"
            fi

            # Core Hyprland packages
            CORE_PACKAGES=(
                hyprland
                hyprpaper
                hypridle
                hyprlock
                xdg-desktop-portal-hyprland
            )

            # UI and utilities
            UI_PACKAGES=(
                waybar
                mako
                kanshi
                rofi
                kitty
            )

            # Additional tools
            TOOL_PACKAGES=(
                cava
                fastfetch
                matugen
                cliphist
                waypaper
                playerctl
                blueman
                wl-clipboard
                wl-clip-persist
                socat
                grim
                slurp
                hyprshot
                hyprpicker
                satty
            )

            # Optional but recommended
            OPTIONAL_PACKAGES=(
                pavucontrol
                network-manager-applet
                polkit-gnome
                qt5-qtwayland
                qt6-qtwayland
            )

            ALL_PACKAGES=("${CORE_PACKAGES[@]}" "${UI_PACKAGES[@]}" "${TOOL_PACKAGES[@]}" "${OPTIONAL_PACKAGES[@]}")

            log_info "Installing ${#ALL_PACKAGES[@]} packages..."
            sudo dnf install -y "${ALL_PACKAGES[@]}" || log_warn "Some packages failed to install"
            ;;

        apt)
            log_warn "APT support is basic. You may need to install some packages manually."
            sudo apt update
            sudo apt install -y \
                waybar mako-notifier kanshi rofi kitty \
                cava fastfetch playerctl blueman wl-clipboard \
                socat \
                grim slurp pavucontrol network-manager-gnome \
                || log_warn "Some packages failed to install"
            
            log_warn "Hyprland, hyprpaper, hypridle, hyprlock, matugen, cliphist, waypaper may need manual installation"
            ;;

        pacman)
            log_warn "Pacman support is basic. You may need to install some packages manually."
            sudo pacman -Syu --noconfirm \
                hyprland hyprpaper hypridle hyprlock \
                waybar mako kanshi rofi kitty \
                cava fastfetch playerctl blueman wl-clipboard \
                socat \
                grim slurp pavucontrol network-manager-applet \
                || log_warn "Some packages failed to install"
            
            log_warn "matugen, cliphist, waypaper may need to be installed from AUR"
            ;;
    esac

    log_info "Package installation complete"
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

# Parse command line arguments
SKIP_PACKAGES=false
while [[ $# -gt 0 ]]; do
    case $1 in
        --skip-packages)
            SKIP_PACKAGES=true
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  --skip-packages    Skip package installation"
            echo "  -h, --help        Show this help message"
            exit 0
            ;;
        *)
            log_error "Unknown option: $1"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

log_section "Dotfiles Installation Script"

# Detect system
detect_system

# Install packages unless skipped
if [ "$SKIP_PACKAGES" = false ]; then
    read -p "Do you want to install required packages? [Y/n] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
        install_packages
    else
        log_warn "Skipping package installation"
    fi
else
    log_warn "Package installation skipped (--skip-packages flag)"
fi

# Create config directory if it doesn't exist
log_section "Linking configuration files"
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
    "satty"
    "waybar"
    "waypaper"
    "systemd"
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

# Create Screenshots directory
mkdir -p "$HOME/Pictures/Screenshots"
log_info "Created Screenshots directory at ~/Pictures/Screenshots"

log_section "Setting up permissions and services"

# Make scripts executable
log_info "Making scripts executable..."
find "$CONFIG_DEST/hypr/scripts" -type f -name "*.sh" -exec chmod +x {} \; 2>/dev/null
find "$CONFIG_DEST/waybar/scripts" -type f -name "*.sh" -exec chmod +x {} \; 2>/dev/null
find "$CONFIG_DEST/rofi" -type f -name "*.sh" -exec chmod +x {} \; 2>/dev/null
find "$CONFIG_DEST/matugen/scripts" -type f -name "*.sh" -exec chmod +x {} \; 2>/dev/null
log_info "Scripts made executable"

log_section "Configuring system services"

# Setup systemd-logind for lid switch handling
log_info "Configuring systemd-logind for lid switch handling..."
if [ ! -d /etc/systemd/logind.conf.d ]; then
    log_warn "Creating /etc/systemd/logind.conf.d/ requires sudo"
    sudo mkdir -p /etc/systemd/logind.conf.d
fi

if [ ! -f /etc/systemd/logind.conf.d/lid-switch.conf ]; then
    log_info "Creating lid-switch configuration..."
    sudo tee /etc/systemd/logind.conf.d/lid-switch.conf > /dev/null <<EOF
[Login]
HandleLidSwitch=ignore
HandleLidSwitchExternalPower=ignore
HandleLidSwitchDocked=ignore
EOF
    log_info "Restarting systemd-logind..."
    sudo systemctl restart systemd-logind
    log_info "Systemd-logind configured to ignore lid switch (Hyprland will handle it)"
else
    log_info "Lid switch configuration already exists, skipping"
fi

# Enable kanshi user service
log_info "Enabling kanshi user service..."
systemctl --user daemon-reload 2>/dev/null
systemctl --user enable kanshi.service 2>/dev/null || log_warn "Could not enable kanshi.service (it may not be installed yet)"
log_info "Starting kanshi user service..."
systemctl --user start kanshi.service 2>/dev/null || log_warn "Could not start kanshi.service (will start on next login)"

log_section "Installation Summary"

log_info "Dotfiles installation complete!"
if [ "$backup_created" = true ]; then
    log_info "Existing configs backed up to: $BACKUP_DIR"
fi

echo ""
echo "Configuration Summary:"
echo "  - Config files linked to: $CONFIG_DEST"
echo "  - Systemd user services linked to: $CONFIG_DEST/systemd/user"
echo "  - Scripts made executable"
echo "  - Systemd-logind configured for lid switch handling"
echo "  - Kanshi service installed, enabled, and started"

if [ "$SKIP_PACKAGES" = true ] || [[ ! $REPLY =~ ^[Yy]$ ]] 2>/dev/null; then
    echo ""
    log_warn "Packages were not installed. You may need to install them manually:"
    echo ""
    echo "  Fedora (with solopasha/hyprland COPR):"
    echo "    sudo dnf copr enable solopasha/hyprland -y"
    echo "    sudo dnf install hyprland hyprpaper hypridle hyprlock waybar mako kanshi rofi kitty \\"
    echo "                     cava fastfetch matugen cliphist waypaper playerctl blueman wl-clipboard \\"
    echo "                     grim slurp hyprshot hyprpicker pavucontrol network-manager-applet"
    echo ""
fi

echo ""
log_section "Next Steps"
echo "  1. Logout and select 'Hyprland' from your display manager"
echo "  2. Or reboot your system"
echo "  3. Press SUPER+R to launch rofi search"
echo "  4. Press SUPER+Q to open kitty terminal"
echo "  5. Lid switch will automatically manage monitor configurations"
echo ""
log_info "For keybindings, see: ~/.config/hypr/config/keybinds.conf"
log_info "To set wallpaper: Press SUPER+SHIFT+W (waypaper)"
