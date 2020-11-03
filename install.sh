#! /bin/bash

ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc
ln -s $HOME/.dotfiles/.vimrc $HOME/.vimrc
ln -s $HOME/.dotfiles/.p10k.zsh $HOME/.p10k.zsh


if [[ "$OSTYPE" == "darwin"* ]];then
    pip install virtualenv virtualenvwrapper
elif [[ "$OSTYPE" == "linux-gnu"* ]];then
    sudo apt install -y python3
    sudo apt install -y python3-pip
    sudo pip3 install virtualenv virtualenvwrapper
fi



if [ -f $HOME/.zsh ];then
    echo ".zsh Directory already there"
elif
    mkdir -p $HOME/.zsh/plugins $HOME/.zsh/themes
    git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.zsh/zsh-syntax-highlighting
    git clone https://github.com/romkatv/powerlevel10k.git $HOME/.zsh/themes/powerlevel10k
fi


if [-f $HOME/.vim ];then
    echo ".vim Directory already there"
elif
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi


if [ -f $HOME/.pyenv ];then
    echo "Pyenv Directory already present"
elif
    curl https://pyenv.run | zsh
    exec $SHELL
    git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git $(pyenv root)/plugins/pyenv-virtualenvwrapper
fi
