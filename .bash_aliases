# ~/.bash_aliases
alias ansible-inventory='gpg-connect-agent updatestartuptty /bye &>/dev/null && ansible-inventory'
alias ansible-playbook='gpg-connect-agent updatestartuptty /bye &>/dev/null && ansible-playbook'
alias c='clear'
alias cat='bat'
alias cp='cp -iv'
alias diff='diff -s'
alias egrep='egrep --colour=auto'
alias ga='git add'
alias gb='git branch'
alias gc='git commit -S'
alias gd='git diff'
alias gdt='git difftool'
alias gf='git fetch'
alias gl='git log'
alias gm='git merge'
alias gmt='git mergetool'
alias godoc='godoc -ex'
alias gpl='git pull'
alias gps='git push'
alias grep='grep --colour=auto'
alias gs='git status'
alias h='helm'
alias hidehist='history -d $((HISTCMD-2))'
alias irb='irb --simple-prompt'
alias k='kubectl'
alias la='ls -AbF --time-style=+%d-%m-%y'
alias ldate='date +%Y-%m-%d-%H%M'
alias less='less -Rr'
alias ll='ls -lbFh --time-style=+%d-%m-%y'
alias ls='ls --color=auto -v -Q --quoting-style=escape'
alias mv='mv -i'
alias p='podman'
alias rm='rm -i'
alias scp='gpg-connect-agent updatestartuptty /bye &>/dev/null && scp'
alias sdate='date +%Y-%m-%d'
alias sl='ls'
alias ssh='gpg-connect-agent updatestartuptty /bye &>/dev/null && ssh'
alias sudo='A=`alias` sudo '
alias tree='tree -AC'
alias vim='nvim'
alias vimdiff='nvim -d'

# Completions for aliases
if type -t __start_kubectl &>/dev/null; then
    complete -f -F __start_kubectl k
fi
if type -t __start_helm &>/dev/null; then
    complete -F __start_helm h
fi
podman_completions=/usr/share/bash-completion/completions/podman
if [ -f "${podman_completions}" ]; then
    if ! type -t __start_podman &>/dev/null; then
        source "${podman_completions}"
    fi
    complete -F __start_podman p
fi
unset podman_completions
