# --- Navigation ---
alias ..='cd ..'
alias ...='cd ../..'
alias ~="cd ~"

# --- Safety ---
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# --- Git ---
alias uncommit='git reset --soft HEAD~1'
alias glg='git log --graph --oneline --decorate --all'

# --- OS Specific ---
if [[ "$OSTYPE" == "darwin"* ]]; then
    alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    alias aptup='sudo apt update && sudo apt upgrade'
fi