#!/usr/bin/env zsh

# - - - - - - - - - - - - - -
# History
# - - - - - - - - - - - - - -
setopt append_history
setopt share_history
setopt inc_append_history
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_allow_clobber
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_ignore_space

# - - - - - - - - - - - - - -
# Directory navigation
# - - - - - - - - - - - - - -
setopt auto_cd
setopt auto_pushd
setopt pushd_silent
setopt pushd_ignore_dups

# - - - - - - - - - - - - - -
# Completion
# - - - - - - - - - - - - - -
setopt auto_list
setopt list_ambiguous
setopt list_types
# setopt no_auto_menu
# setopt auto_menu
# setopt list_beep
# setopt always_to_end

# - - - - - - - - - - - - - -
# Globbing / File Matching
# - - - - - - - - - - - - - -
setopt extended_glob
setopt local_options
# setopt glob_dots

# - - - - - - - - - - - - - -
# Misc
# - - - - - - - - - - - - - -
setopt beep
# setopt correct_all
# setopt correct

# - - - - - - - - - - - - - -
# Prompt
# - - - - - - - - - - - - - -
setopt promptsubst
