#!/usr/bin/env zsh

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# ZSH Profiling
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
zmodload zsh/zprof

type load_file_if_exists &> /dev/null 2>&1 || source "${HOME}/.shellrc"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Load configurations
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
config_files=(
  "history.zsh"
  "options.zsh"
  "zinit.zsh"
  "aliases.zsh"
  "completions.zsh"
)

for config in "${config_files[@]}"; do
  load_file_if_exists "${ZDOTDIR}/config/${config}"
done

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Evalcache configuration
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
command_exists mise && _evalcache mise activate zsh
command_exists zoxide && _evalcache zoxide init zsh --cmd cd
command_exists fzf && _evalcache fzf --zsh
command_exists brew && _evalcache brew shellenv
# command_exists direnv && _evalcache direnv hook zsh

# https://github.com/zsh-users/zsh-autosuggestions?tab=readme-ov-file#suggestion-strategy
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Preferred editor for remote sessions
is_non_zero_string "${SSH_CONNECTION}" && export EDITOR="vi"

command_exists vi && ! is_non_zero_string "${EDITOR}" && export EDITOR="vi"

path_add "${PERSONAL_BIN_DIR}"

# Enable colors
autoload -Uz colors && colors

if command_exists brew; then
  export HOMEBREW_NO_ANALYTICS=1
  export HOMEBREW_CLEANUP_MAX_AGE_DAYS=3
  export HOMEBREW_CLEANUP_PERIODIC_FULL_DAYS=3
  export HOMEBREW_BAT=1
  export HOMEBREW_VERBOSE_USING_DOTS=1
  export HOMEBREW_CASK_OPTS="--no-quarantine"

  # load_file_if_exists "${HOME}/.config/devbox/lib/use_devbox.sh"

  CURL_DIR="${HOMEBREW_PREFIX}/opt/curl"
  path_add "${CURL_DIR}/bin" before
fi

# Use bat to colorize man pages
command_exists bat && export MANPAGER="sh -c 'col -bx | bat -l man -p'"

command_exists _awsp && alias awsp="source _awsp"

# remove empty components to avoid '::' ending up + resulting in './' being in $PATH, etc
path=( "${path[@]:#}" )
fpath=( "${fpath[@]:#}" )
infopath=( "${infopath[@]:#}" )
manpath=( "${manpath[@]:#}" )
# path_clean

# remove duplicates from some env vars
typeset -gU cdpath CPPFLAGS cppflags FPATH fpath infopath LDFLAGS ldflags MANPATH manpath PATH path PKG_CONFIG_PATH

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
load_file_if_exists "${HOME}/.sdkman/bin/sdkman-init.sh"
