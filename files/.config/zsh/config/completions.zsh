#!/usr/bin/env zsh

if [[ -z "$ZSH_COMPDUMP_REBUILT" ]]; then
  autoload -Uz compinit
  compinit -C -d "${XDG_CACHE_HOME}/zcompdump-${ZSH_VERSION}"
  export ZSH_COMPDUMP_REBUILT=1
fi

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# zstyle ':completion:*:*:docker:*' option-stacking yes
# zstyle ':completion:*:*:docker-*:*' option-stacking yes