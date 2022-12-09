#! /bin/bash

conda_install() {

    curl -sL  "https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh" >  "Miniconda3.sh"
    zsh Miniconda3.sh
    rm Miniconda3.sh
}


conda_install


