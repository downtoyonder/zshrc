#!/bin/zsh

if [ "$1" = "uninstall" ]; then
    echo "First argument is 'uninstall'"
	exit 0;
fi

if [ ! -d "zplug/.git" ]; then
    git submodule update --init
fi

rm -f ~/.zshrc 

ln config/zshrc.zsh ~/.zshrc

source ~/.zshrc
