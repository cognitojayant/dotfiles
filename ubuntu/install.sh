#!/bin/bash

set -x
set -v
set -e

# Basic validations and helpers
require_command() {
    if ! command -v "$1" >/dev/null 2>&1; then
        echo "Required command '$1' not found. Please install it and re-run the script."
        exit 1
    fi
}

is_ubuntu() {
    if [[ "$(uname)" != "Linux" ]] || ! command -v apt >/dev/null 2>&1; then
        echo "This installer is intended for Ubuntu/Debian only."
        exit 1
    fi
}

safe_ln() {
    local src="$1" dst="$2"
    if [ -L "$dst" ]; then
        echo "Removing existing symlink $dst"
        rm -f "$dst"
    elif [ -e "$dst" ]; then
        echo "$dst exists and is not a symlink; moving to ${dst}.bak"
        mv "$dst" "${dst}.bak"
    fi
    ln -s "$src" "$dst"
}

# Validate environment early
is_ubuntu
require_command git
require_command curl

install_zsh() {
    echo "Installing zsh..."
    sudo apt update -y
    sudo apt install -y zsh
    chsh -s "$(which zsh)"
    echo "Default shell changed to zsh. Please log out and back in for it to take effect."
}

zsh_plugin() {
    require_command git
    mkdir -p "$HOME/.zsh/plugins" "$HOME/.zsh/themes"

    install_or_update() {
        local url="$1"
        local dest="$2"
        local name="$3"

        if [ -d "$dest/.git" ]; then
            echo "Updating $name"
            git -C "$dest" pull --ff-only || echo "Could not update $name"
        elif [ -d "$dest" ] && [ "$(ls -A "$dest")" ]; then
            echo "$name exists but is not a git repo; skipping"
        else
            echo "Cloning $name"
            git clone "$url" "$dest"
        fi
    }

    install_or_update "https://github.com/zsh-users/zsh-autosuggestions" "$HOME/.zsh/plugins/zsh-autosuggestions" "zsh-autosuggestions"
    install_or_update "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$HOME/.zsh/plugins/zsh-syntax-highlighting" "zsh-syntax-highlighting"
    install_or_update "https://github.com/romkatv/powerlevel10k.git" "$HOME/.zsh/themes/powerlevel10k" "powerlevel10k"
}

install_uv() {
    echo "Installing uv..."
    require_command curl
    curl -LsSf https://astral.sh/uv/install.sh | sh
}


install_zsh
zsh_plugin
install_uv


safe_ln "$HOME/.dotfiles/ubuntu/.zshrc" "$HOME/.zshrc"
