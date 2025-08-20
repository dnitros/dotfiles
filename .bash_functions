#!/usr/bin/env bash

# Prompt colors
COLOR256=()
COLOR256[0]="${RED}"
COLOR256[256]="${NO_COLOR}"
COLOR256[257]="${BOLD}"

PROMPT_COLORS=()

set_prompt_colors() {
  local h=${1:-0}
  local color=
  local i=0
  local j=0
  for i in {22..231}; do
    ((i % 30 == h)) || continue

    color=${COLOR256[$i]}
    # cache the tput colors
    if [[ -z $color ]]; then
    COLOR256[$i]=$(tput setaf "$i")
    color=${COLOR256[$i]}
    fi
    PROMPT_COLORS[$j]=$color
    ((j++))
  done
}

# Prompt command
_prompt_command() {
  local user=$USER
  local host=${HOSTNAME%%.*}
  local pwd=${PWD/#$HOME/\~}
  local ssh=
  is_non_zero_string "${SSH_CLIENT}" && ssh='[ssh] '
  printf "\033]0;%s%s@%s:%s\007" "$ssh" "$user" "$host" "$pwd"
}

# Print all 256 colors
colors() {
  local i
  for i in {0..255}; do
    printf "\x1b[38;5;${i}mcolor %d\n" "$i"
  done
  tput sgr0
}
