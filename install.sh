#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

case "$(uname -s)" in
    Darwin)
        echo "Detected macOS — running mac installer..."
        exec "$DOTFILES_DIR/mac/install_mac.sh"
        ;;
    Linux)
        if command -v apt >/dev/null 2>&1; then
            echo "Detected Ubuntu/Debian — running ubuntu installer..."
            exec "$DOTFILES_DIR/ubuntu/install.sh"
        else
            echo "Unsupported Linux distribution (apt not found)."
            exit 1
        fi
        ;;
    *)
        echo "Unsupported OS: $(uname -s)"
        exit 1
        ;;
esac
