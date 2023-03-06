#!/bin/zsh
rm -f ~/.zshrc_bk
mv ~/.zshrc ~/.zshrc_bk
ln config/zshrc.zsh ~/.zshrc
source ~/.zshrc
