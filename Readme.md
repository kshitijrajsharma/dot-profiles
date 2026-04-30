# My Dotfiles

A cross-platform Zsh configuration for macOS and Linux (Ubuntu/Debian and Fedora).
It automates the installation of shell themes, plugins, and custom aliases.

## Contents
* Shell: Zsh with Oh My Zsh
* Theme: Powerlevel10k
* Plugins:
    * zsh-autosuggestions
    * zsh-syntax-highlighting
    * history-substring-search (bundled with Oh My Zsh)
* OS Awareness: Detects Mac (Homebrew) vs Linux (APT / DNF).

---

## Quick Install

1.  Clone the repository:
    ```bash
    git clone https://github.com/kshitijrajsharma/dot-profiles.git
    ```

2.  Run the setup script:
    ```bash
    cd dot-profiles/dotfiles
    chmod +x install.sh
    ./install.sh
    ```

3.  Configure Powerlevel10k:
    * The script ends by launching zsh, so the Powerlevel10k wizard starts automatically.
    * If you skip it or want to redo it later, run `p10k configure`.
    * Set your terminal font to **MesloLGS NF** so the prompt glyphs render correctly.

---

## Management

### Adding new Aliases
1.  Open `dot-profiles/dotfiles/aliases.zsh`.
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
    cd dot-profiles
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
