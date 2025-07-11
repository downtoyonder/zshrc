# =============================================================================
# Optimized ZSHRC Configuration
# Generated on: Tue Jun  3 11:42:31 AM CST 2025
# =============================================================================

# Set configuration directory
export ZSH_CONFIG="/home/don/.config/zshrc/config"
export ZSH_CACHE="$HOME/.cache/zshrc"

# Enable optimization features
export ENABLE_AUTO_OPTIMIZATION=1
export PERFORMANCE_MONITORING=1
export PRINT_TIME_COST=0 # Set to 1 to see timing information

# Source the optimized configuration
if [[ -f "$ZSH_CONFIG/zshrc.zsh" ]]; then
	source "$ZSH_CONFIG/zshrc.zsh"
else
	echo "⚠️  Optimized zshrc config not found at $ZSH_CONFIG/zshrc.zsh"
	echo "   Please check your installation or run the deployment script again."
fi

# Add any custom configurations below this line
# -----------------------------------------------------------------------------
