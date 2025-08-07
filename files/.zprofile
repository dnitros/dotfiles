#!/usr/bin/env zsh

export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'
export LC_COLLATE='en_US.UTF-8'
export LC_CTYPE='en_US.UTF-8'
export LC_MESSAGES='en_US.UTF-8'
export LC_MONETARY='en_US.UTF-8'
export LC_NUMERIC='en_US.UTF-8'
export LC_TIME='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export LESSCHARSET='utf-8'

export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

export DOTFILES_DIR="${HOME}/.dotfiles"
export PERSONAL_BIN_DIR="${HOME}/bin"
export HOMEBREW_PREFIX="/opt/homebrew"

export PATH="${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:${PATH+:$PATH}"
