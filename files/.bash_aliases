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

# neovim broken on `v0.11.1`
# many plugin needs fix - will revisit
# if command_exists nvim; then
#   alias vi='nvim'
# elif command_exists vim; then
#   alias vi='vim'
# fi
command_exists bat && alias cat='bat'
command_exists btop && alias top='btop'

if command_exists brew; then
  alias bcg='brew outdated --greedy'
  alias bcug='brew upgrade --greedy'
  alias bupc='brew bundle check || brew bundle --all --cleanup; brew bundle cleanup -f --zap; brew cleanup --prune=all; brew autoremove; brew upgrade'
fi
