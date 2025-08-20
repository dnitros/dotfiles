#!/usr/bin/env zsh

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# ZSH Profiling
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
zmodload zsh/zprof

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Load shellrc
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
type load_file_if_exists &> /dev/null 2>&1 || source "${HOME}/.shellrc"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Enable Powerlevel10k instant prompt
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
load_file_if_exists "${XDG_CACHE_HOME}/p10k-instant-prompt-$(whoami).zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Load environment variables
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Evalcache cache storage directory, default $HOME/.zsh-evalcache
export ZSH_EVALCACHE_DIR="${XDG_STATE_HOME}/zsh/.zsh-evalcache"

# https://github.com/zsh-users/zsh-autosuggestions#suggestion-strategy
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# fzf catppuccin-mocha theme
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#6C7086,label:#CDD6F4"

# Preferred editor
is_non_zero_string "${SSH_CONNECTION}" && export EDITOR="vi"
command_exists vi && ! is_non_zero_string "${EDITOR}" && export EDITOR="vi"

# Use bat to colorize man pages
command_exists bat && export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# k3s kubeconfig
command_exists k3s && export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

# Brew variables
if command_exists brew; then
  export HOMEBREW_NO_ANALYTICS=1
  export HOMEBREW_CLEANUP_MAX_AGE_DAYS=3
  export HOMEBREW_CLEANUP_PERIODIC_FULL_DAYS=3
  command_exists bat && export HOMEBREW_BAT=1
  export HOMEBREW_VERBOSE_USING_DOTS=1
  is_macos && export HOMEBREW_CASK_OPTS="--no-quarantine"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Load configurations
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
config_files=(
  "history.zsh"
  "options.zsh"
  "key-bindings.zsh"
  "zinit.zsh"
  "aliases.zsh"
  "completions.zsh"
  "functions.zsh"
)

for config in "${config_files[@]}"; do
  load_file_if_exists "${ZDOTDIR}/config/${config}"
done

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Path Configuration
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
path_add "${PERSONAL_BIN_DIR}"
path_remove "/usr/local/games"
path_remove "/usr/games"

if command_exists brew; then
  CURL_DIR="${HOMEBREW_PREFIX}/opt/curl"
  path_add "${CURL_DIR}/bin" before
fi

# Remove empty components to prevent '::' or './' in $PATH and related issues
path=( "${path[@]:#}" )
fpath=( "${fpath[@]:#}" )
infopath=( "${infopath[@]:#}" )
manpath=( "${manpath[@]:#}" )
# path_clean

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Evalcache configuration
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
command_exists mise && _evalcache mise activate zsh
command_exists zoxide && _evalcache zoxide init zsh --cmd cd
command_exists fzf && _evalcache fzf --zsh
is_linux && command_exists brew && _evalcache brew shellenv
# command_exists direnv && _evalcache direnv hook zsh

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Miscellaneous configuration
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Enable colors
autoload -Uz colors && colors

# Remove / from wordchar - easier to do ctrl+w to delete a word from path
WORDCHARS="${WORDCHARS/\//}"

# Remove duplicates from some env vars
typeset -gU cdpath CPPFLAGS cppflags FPATH fpath infopath LDFLAGS ldflags MANPATH manpath PATH path PKG_CONFIG_PATH

# This must be at the end of the file for SDKMAN to work!!!
load_file_if_exists "${HOME}/.sdkman/bin/sdkman-init.sh"
