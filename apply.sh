#!/bin/zsh
# if zsh not installed, the script will be executed by the default shell

# Check if zsh is installed
if ! command -v zsh >/dev/null; then
	echo "zsh is not installed"
	exit 0
fi

# Check if zsh is the default shell
if [[ $SHELL != *zsh* ]]; then
	echo "zsh is not the default shell"
	read -p "Do you want to change the default shell to zsh? (y/n) " input
	if [[ $input == "y" ]]; then
		chsh -s $(which zsh)
		echo "zsh has been set as the default shell."
	else
		exit 0
	fi
fi

if [ ! -d "zplug/.git" ]; then
	git submodule update --init
fi

rm -f ~/.zshrc
ln config/zshrc.zsh ~/.zshrc
source ~/.zshrc
