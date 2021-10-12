# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return




# General settings
#
# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
#
# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar
#
# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe.sh ] && eval "$(SHELL=/bin/sh lesspipe.sh)"


# Prompt
#
git_prompt_sh="/usr/share/git/git-prompt.sh"
if [ -e "$git_prompt_sh" ]; then
    export GIT_PS1_SHOWDIRTYSTATE=true
    export GIT_PS1_SHOWSTASHSTATE=true
    export GIT_PS1_SHOWUNTRACKEDFILES=true
    source "$git_prompt_sh"
    PS1='\[\033[1;30m\]\u@\[\033[38;5;66m\]\h\[\033[01;34m\] \w \[\033[38;5;66m\]$(__git_ps1 "\n[%s] ")\[\033[01;34m\]\$\[\033[00m\] '
else
    PS1='\[\033[1;30m\]\u@\[\033[38;5;66m\]\h\[\033[01;34m\] \w \$\[\033[00m\] '
fi




# History Control
#
# Don't put duplicate lines or lines starting with space in the history.
export HISTCONTROL=ignoreboth:erasedups
# Ignore the following patterns when appending to the history file
# export HISTIGNORE="ls:ll:la:cd**:history**:top:exit:tree**:c:clear"
# For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=100000
export HISTFILESIZE=200000
# Synchronise history across multiple sessions;
# history -a appends the current command to the history file. history -c
# then clears the history after which history -r reads and updates the
# current state of the history, thereby reading in any changes from other
# sessions. PROMPT_COMMAND is run prior to the issue of the primary prompt.
export PROMPT_COMMAND="history -a;history -c;history -r"
# Append to the history file, don't overwrite it
shopt -s histappend
# Smart handling of multiline commands - attempt to save each line of a
# multi-line command in the same history entry
shopt -s cmdhist




# Colour support
#
# Enable colourisation of listings for different file types etc
if [ -x /usr/bin/dircolors ]; then
    if [ -r "$HOME"/.dircolors ]; then
        eval "$(dircolors -b "$HOME/.dircolors")"
    else
        eval "$(dircolors -b)"
    fi
fi
#
# Colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
#
# Colour support for manpages
export LESS_TERMCAP_mb=$'\e[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\e[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\e[0m'           # end mode
export LESS_TERMCAP_so=$'\e[01;38;5;154m' # begin standout-mode - info box
export LESS_TERMCAP_se=$'\e[0m'           # end standout-mode
export LESS_TERMCAP_us=$'\e[04;38;5;72m'  # begin underline
export LESS_TERMCAP_ue=$'\e[0m'           # end underline




# Application settings and configuration

# GPG and GPG Agent Settings
GPG_TTY="$(tty)"
export GPG_TTY
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
    export SSH_AUTH_SOCK
fi

# Set up direnv
if command -v direnv &>/dev/null; then
    eval "$(direnv hook bash)"
fi

# Virtualenvwrapper
export WORKON_HOME="${HOME}/.virtualenvs"
source /usr/bin/virtualenvwrapper.sh

# Local completions directory
completiond="${HOME}/.local/share/bash_completion.d"

# tmux completions
# https://github.com/Bash-it/bash-it/blob/master/completion/available/tmux.completion.bash
tmux_completions="${completiond}/tmux/tmux_completion.bash"
if [ -f "${tmux_completions}" ]; then
    source "${tmux_completions}"
fi
unset tmux_completions

# Go command completions
# https://github.com/thomasf/go-bash-completion.git
go_completions="${completiond}/go/go-bash-completion.bash"
if [ -f "${go_completions}" ]; then
    source "${go_completions}"
fi
unset go_completions

# Packer command completions
# https://github.com/mrolli/packer-bash-completion.git
packer_completions="${completiond}/packer/packer"
if command -v packer &>/dev/null; then
    source "${packer_completions}"
fi
unset packer_completions

# kubectl command completions and shortcuts
if command -v kubectl &>/dev/null; then
    source <(kubectl completion bash)
    export do='--dry-run=client -o yaml'
fi

# Terraform
if command -v terraform &>/dev/null; then
    complete -C terraform terraform
fi

# Helm
if command -v helm &>/dev/null; then
    source <(helm completion bash)
fi

# Hugo
if command -v hugo &>/dev/null; then
    # Completions
    hugo_completions_dir="${completiond}/hugo"
    hugo_completions="${hugo_completions_dir}/hugo.bash"
    [ ! -d "${hugo_completions_dir}" ] && mkdir -p "${hugo_completions_dir}"
    if [ ! -e "${hugo_completions}" ]; then
        hugo gen autocomplete --completionfile="${hugo_completions}" \
            &>/dev/null
    fi
    source "${hugo_completions}"
    unset hugo_completions
fi

# fzf
fzf_completions="/usr/share/fzf/completion.bash"
fzf_keybindings="/usr/share/fzf/key-bindings.bash"
if command -v fzf &>/dev/null; then
    [ -r ${fzf_completions} ] && source ${fzf_completions}
    [ -r ${fzf_keybindings} ] && source ${fzf_keybindings}
    export FZF_DEFAULT_OPTS="--multi --bind 'ctrl-a:select-all'"
fi
unset fzf_completions
unset fzf_keybindings

# Clang
clang_completions="/usr/share/clang/bash-autocomplete.sh"
if [ -r "${clang_completions}" ]; then
    source "${clang_completions}"
fi
unset clang_completions

# UFW
ufw_completions="${completiond}/ufw/ufw.bash"
if command -v ufw &>/dev/null; then
    [ -r "${ufw_completions}" ] && source "${ufw_completions}"
fi
unset ufw_completions

# Molecule
#
# NOTE: The command to enable shell completions is dependant on the version
# of python-click that is installed and may change in future. See:
# https://github.com/ansible-community/molecule/issues/3119
# if command -v molecule &>/dev/null; then
#     eval "$(_MOLECULE_COMPLETE=bash_source molecule)"
# fi

# AWS CLI v2
if command -v aws_completer &>/dev/null; then
    complete -C aws_completer aws
fi

# Amazon EKS - eksctl
if command -v eksctl &>/dev/null; then
    source <(eksctl completion bash)
fi

# Operator SDK
if command -v operator-sdk &>/dev/null; then
    source <(operator-sdk completion bash)
fi

# kubebuilder
if command -v kubebuilder &>/dev/null; then
    source <(kubebuilder completion bash)
fi




# Alias definitions.
#
# Source 'complete-alias' to allow 'automagical' completions for aliases
# See: https://github.com/cykerway/complete-alias
#
# Note: Completion commands for user defined aliases will be stored in
# .bash_aliases rather than in the complete_alias script itself. Therefore
# the complete_alias script must always be sourced before .bash_aliases
compalias="${HOME}/.local/share/bash_completion.d/complete-alias/complete_alias"
[ -r "${compalias}" ] && source "${compalias}"
unset compalias
#
# Source all aliases
[ -r "${HOME}/.bash_aliases" ] && source "${HOME}/.bash_aliases"




# Functions
if command -v pandoc &>/dev/null; then
    md () {
        pandoc -t plain "$1" | less
    }
fi
