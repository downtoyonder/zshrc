# ************************************************************** #
# * 应用相关配置
# ************************************************************** #

export EDITOR="vim"

# * Conda
function conda_init() {
	unfunction conda_init
	if [[ -d "$HOME/mambaforge-pypy3" ]]; then
		conda_provider=mambaforge-pypy3
	elif [[ -d "$HOME/miniforge3" ]]; then
		conda_provider=miniforge3
	fi

	unalias conda 2>/dev/null

	__conda_setup="$("$HOME/$conda_provider/bin/conda" 'shell.zsh' 'hook' 2>/dev/null)"
	if [ $? -eq 0 ]; then
		eval "$__conda_setup"
	else
		if [ -f "$HOME/$conda_provider/etc/profile.d/conda.sh" ]; then
			. "$HOME/$conda_provider/etc/profile.d/conda.sh"
		else
			export PATH="$HOME/$conda_provider/bin:$PATH"
		fi
	fi
	unset __conda_setup

	[ -f "$HOME/$conda_provider/etc/profile.d/mamba.sh" ] && . "$HOME/$conda_provider/etc/profile.d/mamba.sh"

	"$HOME/$conda_provider/bin/conda" "$@"
}
alias conda=conda_init

# * Homebrew on linux
function load_brew() {
	unfunction load_brew
	unalias brew 2>/dev/null

	[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

	brew "$@"
}
alias brew=load_brew

#[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# * Golang
export GOPATH=$HOME/go
export GOROOT=/usr/local/go
export GOBIN=$GOPATH/bin
PATH=$GOBIN:$GOROOT/bin:$PATH

# * delve
[[ -x "$(command -v dlv)" ]] && lazy_load_completion "dlv" "dlv completion zsh"

# * ent
[[ -x "$(command -v ent)" ]] && lazy_load_completion "ent" "ent completion zsh"

# * go-callvis
[[ -x "$(command -v go-callvis)" ]] && alias 'go-callvis'="go-callvis -algo=static -cacheDir=./callvis"

# * Zig
PATH=/usr/local/zig:$PATH

# * Rust
PATH="$HOME/.cargo/bin:$PATH"

# * Haskell
PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"

# * Java
plant_uml="$HOME/Applications/cli_apps/plantuml-gplv2-1.2024.4.jar"
[[ -x "$(command -v java)" ]] && alias 'puml'="java -jar $plant_uml"

# * Google Protoc
PATH=/usr/local/protoc/bin:$PATH

# * JetBrains ToolBox
PATH="$HOME/.local/share/JetBrains/Toolbox/scripts:$PATH"

# * Pnpm
PATH="$HOME/.local/share/pnpm:$PATH"

# * yarn
PATH="$HOME/.yarn/bin:$PATH"

# * Prometheus
PATH="$HOME/Applications/prometheus/bin:$PATH"
PATH="$HOME/Applications/node_exporter/bin:$PATH"

# * gem
export GEM_HOME="$HOME/gems"
PATH=$GEM_HOME/bin:$PATH

# * NVM
function load_nvm() {
	unfunction load_nvm
	unalias nvm 2>/dev/null

	export NVM_DIR="$HOME/.config/nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
	nvm "$@"
}
alias nvm=load_nvm

# * bun
function load_bun() {
	unfunction load_bun
	unalias bun 2>/dev/null
	export BUN_INSTALL="$HOME/.bun"
	PATH="$BUN_INSTALL/bin:$PATH"
	[ -s "/home/don/.bun/_bun" ] && source "/home/don/.bun/_bun"
	bun "$@"
}
alias bun=load_bun

# * kubectl
if [[ -x "$(command -v kubectl)" ]]; then
	lazy_load_completion "kubectl" "kubectl completion zsh"
	alias k="kubectl"
fi

# * helm
[[ -x "$(command -v helm)" ]] && lazy_load_completion "helm" "helm completion zsh"

# * minikube/microk8s
if [[ -x "$(command -v minikube)" ]]; then
	lazy_load_completion "minikube" "minikube completion zsh"
	alias mk="minikube"
	alias mkk="minikube kubectl"
elif [[ -x "$(command -v microk8s)" ]]; then
	alias mk="microk8s"
	alias mkk="microk8s kubectl"
	alias mkh="microk8s helm"
fi

# * kind
if [[ -x "$(command -v kind)" ]] && [[ ! -e "${fpath[1]}/_kind" ]]; then
	kind completion zsh >"${fpath[1]}/_kind"
fi

# * golangci-lint
[[ -x "$(command -v golangci-lint)" ]] && lazy_load_completion "golangci-lint" "golangci-lint completion zsh"

# * thefuck
[[ -x "$(command -v thefuck)" ]] && eval $(thefuck --alias)

# * GitHub CLI
if [[ -x "$(command -v gh)" ]]; then
	function load_gh_aliases() {
		unfunction load_gh_aliases
		alias '#'="gh copilot suggest -t shell"
		alias '#g'="gh copilot suggest -t git"
		alias '#gh'="gh copilot suggest -t gh"
		alias '#!'="gh copilot explain"
	}
	load_gh_aliases
fi

# * fzf
# https://github.com/junegunn/fzf
[[ -x "$(command -v fzf)" ]] && lazy_load_completion "fzf" "fzf --zsh"
# --hight 40% 在当前 prompt 下显示 40% 的高度，而非全屏显示
# --layout reverse 使得输入选择框在 prompt 下方一行显示，未设置时将在 prompt、可选框后展示
# without --layout reverse:
# $ fzf # the command line prompt
# |----------------------|
# | the selectable items |
# | ...				     |
# |----------------------|
# | the input box        |
#
# with --layout reverse:
# $ fzf # the command line prompt
# | the input box        |
# |----------------------|
# | the selectable items |
# | ...				     |
# |----------------------|
#
# --border 为 fzf 页面添加一个边框

# 根据上述选项设置 fzf 默认配置
export FZF_DEFAULT_OPTS="--height 50% --layout reverse --border --preview 'fzf-preview.sh {}' --bind 'focus:transform-header:file --brief {}'"
# 默认配置文件
export FZF_DEFAULT_OPTS_FILE=~/.fzfrc
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# * Man page colors
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
