#! /bin/bash 

set -x
set -e
set -v

install_tools() {
    if [[ "$OSTYPE" == "linux-gnu"* ]];then
        echo "install filezilla"
        sudo apt install -y filezilla
        echo "installing brave browser"
        sudo snap install brave
        echo "installing pycharm"
        sudo snap install pycharm-community --classic
        echo "installing vscode"
        sudo snap install pycharm-community --classic
        echo "installing rambox"
        sudo snap install rambox
        echo "installing notion-snap"
        sudo snap install notion-snap
        echo "installing sublime text"
        sudo snap install sublime-text --classic
        echo "Installing rclone"
        curl https://rclone.org/install.sh | sudo bash
    fi
}

install_tools


