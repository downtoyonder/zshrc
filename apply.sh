#!/bin/zsh
rm -f ~/.zshrc_bk
mv ~/.zshrc ~/.zshrc_bk
ln zshrc ~/.zshrc
source ~/.zshrc
