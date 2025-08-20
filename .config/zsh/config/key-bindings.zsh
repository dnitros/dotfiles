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
bindkey -r '^[[A'
bindkey -r '^[[B'
bindkey -r '^[[C'
bindkey -r '^[[D'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# [Home] - Go to beginning of line
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
is_non_zero_string "${terminfo[khome]}" && bindkey -M emacs "${terminfo[khome]}" beginning-of-line
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# [End] - Go to end of line
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
is_non_zero_string "${terminfo[kend]}" && bindkey -M emacs "${terminfo[kend]}" end-of-line

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Function to bind ↑↓ arrow keys for zsh-history-substring-search (zinit plugin)
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function __bind_history_keys() {
  is_non_zero_string "${terminfo[kcuu1]}" && bindkey -M emacs "${terminfo[kcuu1]}" history-substring-search-up
  is_non_zero_string "${terminfo[kcud1]}" && bindkey -M emacs "${terminfo[kcud1]}" history-substring-search-down
}
