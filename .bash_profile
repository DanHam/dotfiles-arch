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

# Molecule requires python-cookiecutter. At present cookiecutter ignores
# XDG settings and splats its config and cache all over the users HOME.
# While a PR to fix this is in progress, a work around is to use an env var
# to specify the location of cookiecutters config file. Within that config
# file we can then specify locations for cookiecutter cache and replay
# directories
# GitHub issue: https://github.com/cookiecutter/cookiecutter/issues/104
cookiecutter_config_dir="$HOME/.config/cookiecutter"
if [ ! -d "${cookiecutter_config_dir}" ]; then
    mkdir "${cookiecutter_config_dir}"
fi
export COOKIECUTTER_CONFIG=${cookiecutter_config_dir}/cookiecutter.yml
unset cookiecutter_config_dir

# Source the bashrc file
[[ -f ~/.bashrc ]] && . ~/.bashrc
