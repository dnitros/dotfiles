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

export TZ='Asia/Kolkata'

export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

export DOTFILES_DIR="${HOME}/dev/dnitros/dotfiles"
export PERSONAL_BIN_DIR="${HOME}/bin"

# github copilot home
export COPILOT_HOME="${XDG_STATE_HOME}/copilot"

# docker config
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"

# ruby bundler config
# export BUNDLE_USER_HOME="${HOME}/.bundle" enable if needed
export BUNDLE_USER_CACHE="${XDG_CACHE_HOME}/bundle"
export BUNDLE_USER_CONFIG="${XDG_CONFIG_HOME}/bundle"
export BUNDLE_USER_PLUGIN="${XDG_DATA_HOME}/bundle"

# claude config directory change
export CLAUDE_CONFIG_DIR="${XDG_CONFIG_HOME}/claude"

OS="$(uname)"
if [[ "${OS}" == "Linux" ]]
then
  export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
  export HOMEBREW_BUNDLE_FILE="${XDG_CONFIG_HOME}/brew/linux/Brewfile"
elif [[ "${OS}" == "Darwin" ]]
then
  export HOMEBREW_PREFIX="/opt/homebrew"
  export HOMEBREW_BUNDLE_FILE="${XDG_CONFIG_HOME}/brew/mac/Brewfile"
fi

export SHELL_SESSION_DIR="${XDG_STATE_HOME}/zsh/sessions"
export SHELL_SESSION_FILE="${SHELL_SESSION_DIR}/${TERM_SESSION_ID}"

export PATH="${HOMEBREW_PREFIX}/bin:/usr/local/bin:/usr/bin:/bin:${HOMEBREW_PREFIX}/sbin:/usr/local/sbin:/usr/sbin:/sbin:${PATH+:$PATH}"
