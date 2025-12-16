#!/usr/bin/env bash

# Colors for output
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Box drawing characters
TOP_LEFT="╭"
TOP_RIGHT="╮"
BOTTOM_LEFT="╰"
BOTTOM_RIGHT="╯"
HORIZONTAL="─"
VERTICAL="│"

print_header() {
    clear
    local title="$1"
    local width=60
    
    echo -e "${CYAN}${TOP_LEFT}$(printf '%*s' $((width-2)) '' | tr ' ' "$HORIZONTAL")${TOP_RIGHT}${NC}"
    printf "${CYAN}${VERTICAL}${NC} ${BOLD}%-*s${NC} ${CYAN}${VERTICAL}${NC}\n" $((width-4)) "$title"
    echo -e "${CYAN}${BOTTOM_LEFT}$(printf '%*s' $((width-2)) '' | tr ' ' "$HORIZONTAL")${BOTTOM_RIGHT}${NC}"
    echo
}

print_section() {
    echo -e "\n${BOLD}${BLUE}▶${NC} ${BOLD}$1${NC}"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${CYAN}ℹ${NC} $1"
}

# Main update function
main() {
    print_header "Fedora Update Center"
    
    # Check for updates first
    print_section "Checking for available updates..."
    
    dnf_count=$(dnf check-update -q 2>/dev/null | grep -E "^[a-zA-Z0-9_+-]+\.[a-zA-Z0-9_]+[[:space:]]" | wc -l)
    flatpak_count=$(flatpak remote-ls --updates 2>/dev/null | wc -l)
    total=$((dnf_count + flatpak_count))
    
    if [ "$total" -eq 0 ]; then
        print_success "System is up to date!"
        print_info "DNF: 0 updates"
        print_info "Flatpak: 0 updates"
        echo
        echo -e "${BOLD}Press any key to exit...${NC}"
        read -n 1 -s
        exit 0
    fi
    
    echo
    print_info "DNF packages: ${BOLD}$dnf_count${NC}"
    print_info "Flatpak apps: ${BOLD}$flatpak_count${NC}"
    print_info "Total updates: ${BOLD}$total${NC}"
    echo
    
    # Update DNF packages
    if [ "$dnf_count" -gt 0 ]; then
        print_section "Updating DNF packages..."
        echo
        
        sudo dnf update --refresh -y
        
        if [ $? -eq 0 ]; then
            echo
            print_success "DNF packages updated successfully"
        else
            echo
            print_error "DNF update failed"
        fi
    fi
    
    # Update Flatpak
    if [ "$flatpak_count" -gt 0 ]; then
        echo
        print_section "Updating Flatpak applications..."
        echo
        
        flatpak update -y
        
        if [ $? -eq 0 ]; then
            echo
            print_success "Flatpak applications updated successfully"
        else
            echo
            print_error "Flatpak update failed"
        fi
    fi
    
    # Clean up
    echo
    print_section "Cleaning up..."
    echo
    
    sudo dnf autoremove -y
    
    if [ $? -eq 0 ]; then
        print_success "Cleanup completed"
    fi
    
    # Final message
    echo
    echo -e "${GREEN}${BOLD}╔════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}${BOLD}║                                                        ║${NC}"
    echo -e "${GREEN}${BOLD}║          ✓ Update process completed!                  ║${NC}"
    echo -e "${GREEN}${BOLD}║                                                        ║${NC}"
    echo -e "${GREEN}${BOLD}╚════════════════════════════════════════════════════════╝${NC}"
    echo
    
    # Check if reboot is needed
    if [ -f /var/run/reboot-required ]; then
        print_warning "System reboot is recommended"
    fi
    
    echo
    echo -e "${BOLD}Press any key to exit...${NC}"
    read -n 1 -s
}

# Run main function
main
