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
# Bind up and down arrow keys for history search until plugin is ready
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
bindkey -r '^[[A'
bindkey -r '^[[B'
function __bind_history_keys() {
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
}

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
  OMZL::key-bindings.zsh \
  OMZL::spectrum.zsh

# +--------------------------+
# | Fast Syntax Highlighting |
# +--------------------------+
zinit ice wait lucid atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay"
zinit light zdharma-continuum/fast-syntax-highlighting
# enable catppuccin theme in using fast-theme
fast-theme XDG:catppuccin-mocha

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

# +-----------+
# | LS Colors |
# +-----------+
zinit ice wait lucid \
  atclone'
    local P=${${(M)OSTYPE:#*darwin*}:+g}
    ${P}sed -i \
    "/DIR/c\DIR 38;5;63;1" LS_COLORS; \
    ${P}dircolors -b LS_COLORS > c.zsh' \
  atload'
    local P=${${(M)OSTYPE:#*darwin*}:+g}
    alias ls="${P}ls --color"
    zstyle ":completion:*" list-colors ${(s.:.)LS_COLORS}' \
  atpull'%atclone' pick"c.zsh" nocompile'!' reset-prompt
zinit light trapd00r/LS_COLORS

# +---------+
# | fzf tab |
# +---------+
zinit ice wait lucid
zinit light Aloxaf/fzf-tab

# +--------------------+
# | ZSH History search |
# +--------------------+
zinit ice wait lucid \
  atinit'HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="fg=white,bold" \
         HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="fg=white,bold"' \
  atload'__bind_history_keys'
zinit light zsh-users/zsh-history-substring-search
