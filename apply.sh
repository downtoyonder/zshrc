#!/bin/zsh

if [ "$1" = "uninstall" ]; then
    echo "First argument is 'uninstall'"
	exit 0;
fi

if [ ! -d "zplug/.git" ]; then
    git submodule update --init
fi

if [ -f "~/.zshrc" ]; then
    rm -f ~/.zshrc 
fi

ln config/zshrc.zsh ~/.zshrc

source ~/.zshrc
