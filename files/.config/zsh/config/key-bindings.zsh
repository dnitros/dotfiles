#!/usr/bin/env zsh

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Enable application mode for valid $terminfo use with ZLE
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Emacs keybind
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
bindkey -e

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Delete ↑↓ arrow key binding
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
bindkey -r '^[[A'
bindkey -r '^[[B'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Function to bind ↑↓ arrow keys for zsh-history-substring-search (zinit plugin)
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function __bind_history_keys() {
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
}
