alias ..='cd ..'
alias ...='cd ../..'
alias ~="cd ~"

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias uncommit='git reset --soft HEAD~1'
alias glg='git log --graph --oneline --decorate --all'

if [[ "$OSTYPE" == "darwin"* ]]; then
    alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if command -v apt &> /dev/null; then
        alias aptup='sudo apt update && sudo apt upgrade'
    elif command -v dnf &> /dev/null; then
        alias dnfup='sudo dnf upgrade --refresh'
    fi
fi
