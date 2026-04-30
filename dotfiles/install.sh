#!/bin/bash
set -u

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Source detected at: $REPO_DIR"

ln -sf "$REPO_DIR" "$HOME/.dotfiles_anchor"

if [[ "$OSTYPE" == "darwin"* ]]; then
    if ! command -v brew &> /dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install zsh git
    brew install --cask iterm2 font-meslo-lg-nerd-font

elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if command -v apt &> /dev/null; then
        sudo apt update
        sudo apt install -y zsh git curl fontconfig
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y zsh git curl fontconfig util-linux-user
    fi
fi

# macOS gets MesloLGS NF from the brew cask above; on Linux install it via getnf.
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # getnf lands in ~/.local/bin, which isn't on PATH in this bash session yet.
    export PATH="$HOME/.local/bin:$PATH"
    if ! command -v getnf &> /dev/null; then
        curl -fsSL https://raw.githubusercontent.com/getnf/getnf/main/install.sh | bash
    fi
    if ! fc-list 2>/dev/null | grep -qi "MesloLGS NF"; then
        getnf -i Meslo || echo "getnf failed; install MesloLGS NF manually."
    fi
fi

# KEEP_ZSHRC=yes prevents OMZ from replacing our symlinked .zshrc on install.
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

[ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ] && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"

# history-substring-search ships with Oh My Zsh, so it isn't cloned here.
[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] && git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

# Timestamped backup so re-runs don't clobber a previous backup.
if [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
    mv "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%s)"
fi

git config --global alias.uncommit 'reset --soft HEAD~1'
git config --global alias.reset-local '!f(){ b=$(git rev-parse --abbrev-ref HEAD); r=${1:-origin}; git fetch -q $r || return 1; git reset --hard $r/$b || return 2; git clean -fd || return 3; echo "Reset to $r/$b"; }; f'

ln -sf "$HOME/.dotfiles_anchor/.zshrc" "$HOME/.zshrc"

ZSH_BIN="$(command -v zsh || true)"
if [ -n "$ZSH_BIN" ] && [ "${SHELL:-}" != "$ZSH_BIN" ]; then
    if ! grep -qx "$ZSH_BIN" /etc/shells 2>/dev/null; then
        echo "$ZSH_BIN" | sudo tee -a /etc/shells >/dev/null
    fi
    chsh -s "$ZSH_BIN" || echo "chsh failed; run 'chsh -s $ZSH_BIN' manually."
fi

echo "Setup complete. Launching zsh — the Powerlevel10k wizard will start."
exec "$ZSH_BIN" -l
