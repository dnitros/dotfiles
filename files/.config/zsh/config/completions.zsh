#!/usr/bin/env zsh

[[ -o interactive ]] || return 0

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# zstyle ':completion:*:*:docker:*' option-stacking yes
# zstyle ':completion:*:*:docker-*:*' option-stacking yes

if [[ -z "$ZSH_COMPDUMP_LOADED" ]]; then
  autoload -Uz compinit

  if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit
  else
    compinit -C
  fi

  ZSH_COMPDUMP_LOADED=1
fi
