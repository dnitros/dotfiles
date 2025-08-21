#!/usr/bin/env zsh

[[ -o interactive ]] || return 0

zstyle ":completion:*" list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always --icons=always $realpath'
zstyle ':fzf-tab:complete:eza:*' fzf-preview '
if [[ -f $realpath ]]; then
    bat --style=numbers --color=always --line-range :500 $realpath
  elif [[ -d $realpath ]]; then
    eza --color=always --icons=always $realpath
  else
    file --mime $realpath
  fi
'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always --icons=always $realpath'
zstyle ':fzf-tab:*' use-fzf-default-opts yes

zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

if [[ -z "$ZSH_COMPDUMP_LOADED" ]]; then
  autoload -Uz compinit

  if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit
  else
    compinit -C
  fi

  ZSH_COMPDUMP_LOADED=1
fi
