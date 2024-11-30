#!/usr/bin/env bash

type command_exists &> /dev/null 2>&1 || source "${HOME}/.shellrc"

alias path='echo -e ${PATH//:/\\n}'
# Enable color support of ls
if ls --color=auto &>/dev/null; then
	alias ls='ls -p --color=auto'
else
	alias ls='ls -p -G'
fi

alias l='ls -lah'
alias la='ls -lAh'
alias ll='ls -lh'
alias md='mkdir -p'
alias rd='rmdir'
alias -- -='cd -'

if command_exists nvim; then
  alias vi='nvim'
elif command_exists vim; then
  alias vi='vim'
fi
command_exists bat && alias cat='bat'
command_exists btop && alias top='btop'
