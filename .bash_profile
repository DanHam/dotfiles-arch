#
# ~/.bash_profile
#

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Set Go path and add the Go bin directory to the system path
export GOPATH=$HOME/working/go
export PATH=$PATH:$GOPATH/bin

# Source the bashrc file
[[ -f ~/.bashrc ]] && . ~/.bashrc
