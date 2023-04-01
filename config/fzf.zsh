# Setup fzf

if [ ! -d "$HOME/.fzf" ]; then
    echo "fzf not installed, installing fzf"
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi
