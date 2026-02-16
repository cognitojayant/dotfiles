#! /bin/bash

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

is_macos() {
    if [[ "$(uname)" != "Darwin" ]]; then
        echo "This installer is intended for macOS only."
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
is_macos
require_command git
require_command curl

# Installing fonts, MacOS font Directory $HOME/Library/Fonts, Linux $HOME/.local/share/fonts
git clone https://github.com/powerline/fonts.git ~/.fonts && cd ~/.fonts && sh install.sh
rm -rf ~/.fonts


installing_brew() {
    echo "Installing Homebrew in MacOS"
    if command -v brew >/dev/null 2>&1; then
        echo "Homebrew already installed"
        return 0
    fi
    require_command curl
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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
    echo "Installing uv in MacOS"
    require_command curl
    curl -LsSf https://astral.sh/uv/install.sh | sh
}


installing_brew
zsh_plugin
install_uv


safe_ln "$HOME/.dotfiles/mac/.zshrc" "$HOME/.zshrc"
safe_ln "$HOME/.dotfiles/mac/.vimrc" "$HOME/.vimrc"
safe_ln "$HOME/.dotfiles/.p10k.zsh" "$HOME/.p10k.zsh"