#!/bin/bash

# Get the directory where this script is located
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Source detected at: $REPO_DIR"

# Create anchor link to allow dynamic sourcing
ln -sf "$REPO_DIR" "$HOME/.dotfiles_anchor"

# --- OS Detection & Package Installation ---
if [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac (Homebrew)
    if ! command -v brew &> /dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install zsh git
    brew install --cask iterm2 font-meslo-lg-nerd-font

elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux (APT)
    if command -v apt &> /dev/null; then
        sudo apt update
        sudo apt install -y zsh git fonts-powerline
    fi
fi

# --- Getnf (Nerd Font Installer) ---
if ! command -v getnf &> /dev/null; then
    curl -fsSL https://raw.githubusercontent.com/getnf/getnf/main/install.sh | bash
fi

# --- Oh My Zsh Setup ---
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# --- Plugins & Theme ---
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

# Theme: Powerlevel10k
[ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ] && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"

# Plugins
[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] && git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
[ ! -d "$ZSH_CUSTOM/plugins/zsh-history-substring-search" ] && git clone https://github.com/zsh-users/zsh-history-substring-search "$ZSH_CUSTOM/plugins/zsh-history-substring-search"

# --- Symlink Configuration ---
# Backup existing .zshrc
if [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
    mv "$HOME/.zshrc" "$HOME/.zshrc.backup"
fi

# git alias
git config --global alias.uncommit 'reset --soft HEAD~1'

git config --global alias.reset-local '!f(){ b=$(git rev-parse --abbrev-ref HEAD); r=${1:-origin}; git fetch -q $r || return 1; git reset --hard $r/$b || return 2; git clean -fd || return 3; echo "Reset to $r/$b"; }; f'


# Link .zshrc via the anchor
ln -sf "$HOME/.dotfiles_anchor/.zshrc" "$HOME/.zshrc"

echo "Setup Complete. Restart your terminal."
