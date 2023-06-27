# ************************************************************** #
# * 应用相关配置
# ************************************************************** #

# * Homebrew
# /usr/local/Cellar

# * Golang
export GOPATH=$HOME/go
export GOROOT=/usr/local/go
export GOBIN=$GOPATH/bin
PATH=$GOBIN:$GOROOT/bin:$PATH

# * Conda
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$("$HOME/mambaforge-pypy3/bin/conda" 'shell.zsh' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
	eval "$__conda_setup"
else
	if [ -f "$HOME/mambaforge-pypy3/etc/profile.d/conda.sh" ]; then
		. "$HOME/mambaforge-pypy3/etc/profile.d/conda.sh"
	else
		export PATH="$HOME/mambaforge-pypy3/bin:$PATH"
	fi
fi
unset __conda_setup

if [ -f "$HOME/mambaforge-pypy3/etc/profile.d/mamba.sh" ]; then
	. "$HOME/mambaforge-pypy3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

# * Rust
PATH="$HOME/.cargo/bin:$PATH"

# * Haskell
PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$HOME/.local/bin:$PATH"

# * Java jdk
PATH="/usr/local/jdk/jdk0.8.0_321/bin:$PATH"

# * Gooogle Protoc
PATH=/usr/local/protoc/bin:$PATH

# * JetBrains ToolBox
PATH="$HOME/.local/share/JetBrains/Toolbox/scripts:$PATH"

# * Pnpm
PATH="$HOME/.local/share/pnpm:$PATH"

# * yarn
# yarn global path
PATH="$HOME/.yarn/bin:$PATH"

# * Prometheus
PATH="$HOME/Applications/prometheus/bin:$PATH"
PATH="$HOME/Applications/node_exporter/bin:$PATH"

# * gem
export GEM_HOME="$HOME/gems"
PATH=$GEM_HOME/bin:$PATH

# * NVM
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

export PATH
