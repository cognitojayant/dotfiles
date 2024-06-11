#!/usr/bin/env zsh

set -e

## VS Code extensions need to be installed

extensions=(
    charliermarsh.ruff
    kevinrose.vsc-python-indent
    ms-python.debugpy
    ms-python.python
    ms-toolsai.jupyter
    ms-toolsai.jupyter-keymap
    ms-toolsai.jupyter-renderers
    ms-toolsai.vscode-jupyter-cell-tags
    ms-toolsai.vscode-jupyter-slideshow
    njpwerner.autodocstring
    tamasfe.even-better-toml
    usernamehw.errorlens
    timonwong.shellcheck
)


# Get a list of all currently installed extensions.
installed_extensions=$(code --list-extensions)



for extension in "${extensions[@]}"; do
    if echo "$installed_extensions" | grep -qi "^$extension$"; then
        echo "$extension is already installed. Skipping..."
    else
        echo "Installing $extension..."
        code --install-extension "$extension"
    fi
done


echo "VS Code extensions have been installed."


if [ $OSTYPE == "linux-gnu" ];then
    VSCODE_USER_SETTINGS_DIR=$HOME/.config/Code/User
    ln -s $HOME/.dotfiles/settings/vscode-settings.json $HOME/.config/Code/User/settings.json
fi







