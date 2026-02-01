# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
  git 
  zsh-autosuggestions 
  zsh-syntax-highlighting 
  history-substring-search
)

source $ZSH/oh-my-zsh.sh

# --- OS Specific Logic ---
if [[ "$OSTYPE" == "darwin"* ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
    alias ls='ls -G'
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
    alias ls='ls --color=auto'
    alias open='xdg-open'
fi

# --- Load Custom Aliases ---
# Source via anchor link to support any clone location
if [ -f "$HOME/.dotfiles_anchor/aliases.zsh" ]; then
    source "$HOME/.dotfiles_anchor/aliases.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
