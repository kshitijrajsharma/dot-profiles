# My Dotfiles

A cross-platform Zsh configuration for macOS and Linux (KDE/Ubuntu).
It automates the installation of shell themes, plugins, and custom aliases.

## Contents
* Shell: Zsh with Oh My Zsh
* Theme: Powerlevel10k
* Plugins:
    * zsh-autosuggestions
    * zsh-syntax-highlighting
    * zsh-history-substring-search
* OS Awareness: Detects Mac (Homebrew) vs Linux (APT).

---

## Quick Install

1.  Clone the repository:
    ```bash
    git clone [https://github.com/kshitijrajsharma/dot-profiles.git](https://github.com/kshitijrajsharma/dot-profiles.git) ~/dotfiles
    ```

2.  Run the setup script:
    ```bash
    cd ~/dotfiles
    chmod +x install.sh
    ./install.sh
    ```

3.  Restart & Configure:
    * Restart your terminal.
    * The Powerlevel10k wizard will start automatically.
    * (If it doesn't start, type `p10k configure`).

---

## Management

### Adding new Aliases
1.  Open `~/dotfiles/aliases.zsh`.
2.  Add your new alias.
3.  Commit & Push:
    ```bash
    git add .
    git commit -m "Added new alias"
    git push
    ```

### Updating on another machine
1.  Go to your dotfiles folder:
    ```bash
    cd ~/dotfiles
    ```
2.  Pull changes and reload:
    ```bash
    git pull
    source ~/.zshrc
    ```

---

## File Structure
* install.sh: Automation script.
* .zshrc: Main config file.
* aliases.zsh: Custom shortcuts.
