#!/usr/bin/env zsh

# Optimizing zsh: https://htr3n.github.io/2018/07/faster-zsh/

# for profiling zsh, see: https://unix.stackexchange.com/a/329719/27109
zmodload zsh/zprof

type load_file_if_exists &> /dev/null 2>&1 || source "${HOME}/.shellrc"

# History configuration
HISTFILE_DIR="${XDG_STATE_HOME}/zsh"
HISTFILE="${HISTFILE_DIR}/history"
! is_directory "${HISTFILE_DIR}" && mkdir -p ${HISTFILE_DIR}
HISTSIZE=20000
SAVEHIST=10000
setopt append_history
setopt share_history
setopt inc_append_history
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_allow_clobber
setopt hist_reduce_blanks
setopt hist_save_no_dups

# Directory navigation
setopt auto_cd
setopt auto_pushd
setopt pushd_silent
setopt pushd_ignore_dups

# Completion
setopt auto_list
setopt list_ambiguous
setopt list_types
# setopt no_auto_menu
# setopt auto_menu
# setopt list_beep
# setopt always_to_end

# Globbing / File Matching
setopt extended_glob
setopt local_options
# setopt glob_dots

# Misc
setopt beep
# setopt correct_all
# setopt correct

# Initialize Homebrew
eval $("${HOMEBREW_PREFIX}/bin/brew" shellenv)

# Initialize oh-my-posh
eval "$(oh-my-posh init zsh --config ${XDG_CONFIG_HOME}/oh-my-posh/config.yaml)"

# Preferred editor for remote sessions
is_non_zero_string "${SSH_CONNECTION}" && export EDITOR="vi"

command_exists vi && ! is_non_zero_string "${EDITOR}" && export EDITOR="vi"

load_file_if_exists "${HOME}/.aliases"

path_add "${PERSONAL_BIN_DIR}"

# Enable colors
autoload -Uz colors && colors

# Docker stacking completions
# zstyle ':completion:*:*:docker:*' option-stacking yes
# zstyle ':completion:*:*:docker-*:*' option-stacking yes

# Initialize completion system
if [[ -z "$ZSH_COMPDUMP_REBUILT" ]]; then
  autoload -Uz compinit
  compinit -C -d "${XDG_CACHE_HOME}/zcompdump-${ZSH_VERSION}"
  export ZSH_COMPDUMP_REBUILT=1
fi

if command_exists brew; then
  export MANPATH="${HOMEBREW_PREFIX}/share/man:${MANPATH}"
  export INFOPATH="${HOMEBREW_PREFIX}/share/info${INFOPATH+:$INFOPATH}"

  export HOMEBREW_NO_ANALYTICS=1
  export HOMEBREW_CLEANUP_MAX_AGE_DAYS=3
  export HOMEBREW_CLEANUP_PERIODIC_FULL_DAYS=3
  export HOMEBREW_BAT=1
  export HOMEBREW_VERBOSE_USING_DOTS=1
  export HOMEBREW_CASK_OPTS="--no-quarantine"

#   command_exists mise && _evalcache mise activate zsh

#   command_exists zoxide && _evalcache zoxide init zsh --cmd cd

  # command_exists direnv && _evalcache direnv hook zsh

  # load_file_if_exists "${HOME}/.config/devbox/lib/use_devbox.sh"

#   CURL_DIR="${HOMEBREW_PREFIX}/opt/curl"
#   path_add "${CURL_DIR}/bin" before
fi

# Use bat to colorize man pages
command_exists bat && export MANPAGER="sh -c 'col -bx | bat -l man -p'"

autoload -Uz add-zsh-hook

fix-prompt-bottom() {
  local term_lines=$(tput lines)  # Total number of terminal lines

  # Move the cursor to last line
  print -n "\e[${term_lines};H"

  # Ensures that ZLE is active before redrawing the prompt
  [[ -n $ZLE ]] && zle reset-prompt
}

add-zsh-hook precmd fix-prompt-bottom

# remove empty components to avoid '::' ending up + resulting in './' being in $PATH, etc
path=( "${path[@]:#}" )
fpath=( "${fpath[@]:#}" )
infopath=( "${infopath[@]:#}" )
manpath=( "${manpath[@]:#}" )
# path_clean

# remove duplicates from some env vars
typeset -gU cdpath CPPFLAGS cppflags FPATH fpath infopath LDFLAGS ldflags MANPATH manpath PATH path PKG_CONFIG_PATH
