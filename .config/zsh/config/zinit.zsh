#!/usr/bin/env zsh

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Install `zinit` and load it
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if ! is_git_repo "${ZINIT_HOME}"; then
  dirname="$(dirname ${ZINIT_HOME})"
  command mkdir -p "${dirname}" && command chmod g-rwX "${dirname}"
  command git clone -q https://github.com/zdharma-continuum/zinit.git "${ZINIT_HOME}"
fi

load_file_if_exists "${ZINIT_HOME}/zinit.zsh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Plugins
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# +-------+
# | Theme |
# +-------+
zinit ice depth=1; zinit light romkatv/powerlevel10k
load_file_if_exists "${ZDOTDIR}/.p10k.zsh"

# +-----------+
# | Evalcache |
# +-----------+
zinit light mroth/evalcache

# +-----+
# | OMZ |
# +-----+
zinit wait lucid for \
  OMZL::directories.zsh \
  OMZL::spectrum.zsh

# setup gcloud completions and path
if command_exists gcloud; then
  CLOUDSDK_HOME="${HOMEBREW_PREFIX}/share/google-cloud-sdk"
  zinit ice wait lucid;
  zinit snippet OMZP::gcloud;
fi

# +---------+
# | fzf tab |
# +---------+
zinit ice wait lucid
zinit light Aloxaf/fzf-tab

# +--------------------------+
# | Fast Syntax Highlighting |
# +--------------------------+
zinit ice wait lucid atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay"
zinit light zdharma-continuum/fast-syntax-highlighting
# enable catppuccin theme in using fast-theme
# fast-theme XDG:catppuccin-mocha

# +-----------------+
# | ZSH Completions |
# +-----------------+
zinit ice wait lucid atpull'zinit creinstall -q .' blockf
zinit light zsh-users/zsh-completions

# +---------------------+
# | ZSH Autosuggestions |
# +---------------------+
zinit ice wait lucid atload"!_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

# +--------------------+
# | ZSH History search |
# +--------------------+
zinit ice wait lucid \
  atinit'HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="fg=white,bold" \
         HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="fg=white,bold"' \
  atload'__bind_history_keys'
zinit light zsh-users/zsh-history-substring-search
