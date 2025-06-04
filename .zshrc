# =============================================================================
# .zshrc to place at $HOME/.zshrc
# =============================================================================

# Set configuration directory
export ZSH_CONFIG="/home/don/.config/zshrc/config"
export ZSH_CACHE="$HOME/.cache/zshrc"

# Source the optimized configuration
if [[ -f "$ZSH_CONFIG/zshrc.zsh" ]]; then
	source "$ZSH_CONFIG/zshrc.zsh"
else
	echo "⚠️  zshrc config not found at $ZSH_CONFIG/zshrc.zsh"
fi

# Add any custom configurations below this line
# -----------------------------------------------------------------------------
