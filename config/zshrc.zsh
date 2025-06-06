# ----------------------- GLOBAL SECTION ------------------------

# Reset PATH to default PATH
# For more information about PATH variable, refer to environment.zsh file `系统级环境变量` part
export PATH=/home/don/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Including the environment variables
# $ZSH_CONFIG variable is avaliable only after source the environment.zsh file
if [[ ! -z "$ZSH_CONFIG" ]]; then
	source "$ZSH_CONFIG/environment.zsh"
else
	source "$HOME/.config/zshrc/config/environment.zsh"
fi

# DEBUG
[[ ! -f $ZSH_CONFIG/debug.zsh ]] || source $ZSH_CONFIG/debug.zsh

# ----------------------- MAIN SECTION ------------------------

# This will introduce functions:
# - source_once
# - elapsed_time
# - lazy_completion
# Load utils.zsh first as it contains essential functions
source "$ZSH_CONFIG/utils.zsh"

# Enable profiling if debug is enabled
if [[ $ZSH_PPROF -eq 1 ]]; then
	zmodload zsh/zprof
fi

# This setting must be at the top of the file to be effective.
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n] confirmations, etc.) must go above this block.
# Everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-$(whoami).zsh" ]]; then
	source_once "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-$(whoami).zsh"
fi

# Load p10k config
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source_once ~/.p10k.zsh

opts=(
	"$ZSH_CONFIG/proxy.zsh"
	"$ZSH_CONFIG/work.zsh"
	"$ZSH_CONFIG/keys.zsh"
)

for opt in "$opts[@]"; do
	[[ -f $opt ]] && source $opt
done

# Group configuration files by priority
# Critical configs first, then system-specific, then application-specific
sources=(
	"$ZSH_CONFIG/alias.zsh"  # Fast, simple aliases
	"$ZSH_CONFIG/option.zsh" # Core zsh options
	"$ZSH_CONFIG/path.zsh"   # PATH management functions
	"$ZSH_CONFIG/zplug.zsh"  # Plugin management
	# System-specific configuration
	"$ZSH_CONFIG/$(uname -s | tr "[:upper:]" "[:lower:]").zsh"
	# Application configs loaded last as they're less critical and can be lazy-loaded
	"$ZSH_CONFIG/function.zsh"    # User functions
	"$ZSH_CONFIG/application.zsh" # Application-specific settings (mostly lazy-loaded now)
)

# Apply all zsh configurations
for file in "$sources[@]"; do
	if [[ -f $file ]]; then
		source_once $file
		elapsed_time "source $file"
	fi
done

# Print startup message and time if enabled
if [[ $ZSH_PPROF -eq 1 ]]; then
	zprof
fi

elapsed_time "finalizer"
