#!/bin/bash
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [[ "$OSTYPE" == "linux-gnu" ]]; then
	source ~/.dotfiles/linux/.bashrc
elif [[ "$OSTYPE" == "darwin"* ]]; then
  echo "MacOS"
fi

# Aviso de bash obsoleto no MAC
export BASH_SILENCE_DEPRECATION_WARNING=1

# Add /usr/local/bin to $PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH

# VIM editor padrao
export VISUAL=vim
export EDITOR="$VISUAL"

export GTK_IM_MODULE=cedilla
export QT_IM_MODULE=cedilla

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.gFreloadz. `echo **/*.txt`
# Case-insensitive globbing (used in pathname expansion)
# Autocorrect typos in path names when using `cd`
# append to the history file, don't overwrite it
# check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
# save all lines of a multiple-line command in the same history entry (allows easy re-editing of multi-line commands)

for option in autocd globstar nocaseglob histignoredups histappend checkwinsize cmdhist; do
	shopt -s "$option" 2> /dev/null;
done;

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL"

# detect your os
case "$OSTYPE" in
  solaris*) SYSTEM_TYPE="SOLARIS" ;;
  darwin*)  SYSTEM_TYPE="OSX" ;;
  linux*)   SYSTEM_TYPE="LINUX" ;;
  bsd*)     SYSTEM_TYPE="BSD" ;;
  msys*)    SYSTEM_TYPE="MINGW" ;;
  cygwin*)  SYSTEM_TYPE="CYGWIN" ;;
esac

# if [[ "$(uname)" == "Darwin" ]]; then
#   SYSTEM_TYPE="OSX"
# elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
#   SYSTEM_TYPE="LINUX"
# elif [[ "$(expr substr $(uname -s) 1 7)" == "FreeBSD" ]]; then
#   SYSTEM_TYPE="FREE_BSD"
# elif [[ "$(expr substr $(uname -s) 1 6)" == "NetBSD" ]]; then
#   SYSTEM_TYPE="NET_BSD"
# elif [[ "$(expr substr $(uname -s) 1 7)" == "OpenBSD" ]]; then
#   SYSTEM_TYPE="OPEN_BSD"
# elif [[ "$(expr substr $(uname -s) 1 7)" == "MSYS_NT" ]]; then
#   SYSTEM_TYPE="MINGW"
# elif [[ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]]; then
#   SYSTEM_TYPE="MINGW"
# elif [[ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]]; then
#   SYSTEM_TYPE="MINGW"
# elif [[ "$(expr substr $(uname -s) 1 9)" == "CYGWIN_NT" ]]; then
#   SYSTEM_TYPE="CYGWIN"
# fi

# if [[ -n "$(cat /proc/version | grep '(Microsoft@Microsoft.com)')" ]]; then
#   SYSTEM_TYPE="Win10_Linux"
# fi

export SYSTEM_TYPE

# Loop por arquivos (dotfile)
# completes,path,load,exports,theme,icons,aliases,functions,extra
for file in ~/.dotfiles/.{functions,exports,colors,theme,icons,completes,aliases}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Abrir nova aba no mesmo diretório
# . /etc/profile.d/vte.sh

# PATHs
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completionexport PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
