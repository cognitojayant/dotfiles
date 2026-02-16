#! /bin/bash 

set -x
set -v
set -e


# Installing fonts, MacOS font Directory $HOME/Library/Fonts, Linux $HOME/.local/share/fonts
git clone https://github.com/powerline/fonts.git ~/.fonts && cd ~/.fonts &&  sh install.sh
rm -rf ~/.fonts 




# Installing python3 in Mac OS using homebrew
if [[ "$OSTYPE" == "darwin"* ]];then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew install python3
else
    echo "This is not Darwin based OS"
fi

change_shell() {
if [[ "$OSTYPE" == "linux-gnu"* ]];then
    echo "Installing ZSH and Changing it to zsh"
    ### After installing and changing to zsh shell need to restart system
    sudo apt install -y zsh
    chsh -s /bin/zsh
    echo "Please restart your computer after the installation script"
elif [[ "$OSTYPE" == "darwin"* ]];then
    echo "changing it to zsh in MacOS"
    ### After installing and changing to zsh shell need to restart system
    sudo apt install -y zsh
    chsh -s /bin/zsh
    echo "Please restart your computer after the installation script"
fi
}

set_python() {
if [[ "$OSTYPE" == "darwin"* ]];then
    echo "Installing virtualenv and virtualenvwrapper in MacOS"
    pip install virtualenv virtualenvwrapper
elif [[ "$OSTYPE" == "linux-gnu"* ]];then
    echo "Installing pip, virtualenv and virtualenvwrapper at system level"
    sudo apt install -y python3
    sudo apt install -y python3-pip
    sudo pip3 install virtualenv virtualenvwrapper
fi
}


zsh_plugin() {
if [[ -f $HOME/.zsh ]];then
    echo ".zsh Directory already there"
else
    echo "Installing plugin in ZSH"
    mkdir -p $HOME/.zsh/plugins $HOME/.zsh/themes
    git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.zsh/plugins/zsh-syntax-highlighting
    git clone https://github.com/romkatv/powerlevel10k.git $HOME/.zsh/themes/powerlevel10k
fi
}

vim_pluging() {
if [[-f $HOME/.vim ]];then
    echo ".vim Directory already there"
elif [[ "$OSTYPE" == "linux-gnu"* ]];then
    echo "Installing curl, vim plugin"
    sudo apt install -y curl
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
}

pyenv_install() {
if [[ "$OSTYPE" == "darwin"* ]] && ! [[ -f $HOME/.pyenv ]];then
    echo "Installing build dependencies"
    brew install openssl readline sqlite3 xz zlib
    curl https://pyenv.run | zsh
    exec $SHELL
    git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git $(pyenv root)/plugins/pyenv-virtualenvwrapper
elif [[ "$OSTYPE" == "linux-gnu"* ]] && ! [[ -f $HOME/.pyenv ]];then
    echo "Installing build dependencies and pyenv"
    sudo apt update; sudo apt install -y --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
    curl https://pyenv.run | zsh
    exec $SHELL
    git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git $(pyenv root)/plugins/pyenv-virtualenvwrapper
fi
}

sdkman_install() {
if [[ -f $HOME/.sdkman ]];then
    echo "sdkman already installed"
else
    echo "installing sdkman"
    curl -s "https://get.sdkman.io" | zsh
fi
}


change_shell
vim_pluging
pyenv_install
sdkman_install


ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc
ln -s $HOME/.dotfiles/.vimrc $HOME/.vimrc
ln -s $HOME/.dotfiles/.p10k.zsh $HOME/.p10k.zsh

