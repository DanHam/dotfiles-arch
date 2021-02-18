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

# Enable completion for aliases using 'complete_alias' (see .bashrc)
complete -F _complete_alias ga
complete -F _complete_alias gb
complete -F _complete_alias gc
complete -F _complete_alias gd
complete -F _complete_alias gdt
complete -F _complete_alias gf
complete -F _complete_alias gl
complete -F _complete_alias gm
complete -F _complete_alias gmt
complete -F _complete_alias gpl
complete -F _complete_alias gps
complete -F _complete_alias gs
complete -F _complete_alias h
complete -F _complete_alias k
complete -F _complete_alias la
complete -F _complete_alias ll
complete -F _complete_alias p
complete -F _complete_alias sl
