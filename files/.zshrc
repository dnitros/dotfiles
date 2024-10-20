#!/usr/bin/env zsh

# Optimizing zsh: https://htr3n.github.io/2018/07/faster-zsh/

# for profiling zsh, see: https://unix.stackexchange.com/a/329719/27109
zmodload zsh/zprof

type load_file_if_exists &> /dev/null 2>&1 || source "${HOME}/.shellrc"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ${HOME}/.zshrc.
load_file_if_exists "${XDG_CACHE_HOME}/p10k-instant-prompt-${USERNAME}.zsh"

load_file_if_exists "${HOME}/.p10k.zsh"
load_file_if_exists "${HOMEBREW_PREFIX}/opt/powerlevel10k/powerlevel10k.zsh-theme"  # intel
load_file_if_exists "${HOMEBREW_PREFIX}/share/powerlevel10k/powerlevel10k.zsh-theme"  # arm

# Path to your oh-my-zsh installation.
export ZSH=${HOME}/.oh-my-zsh

# Set theme to load - possible values "random", "robbyrussell", "powerlevel10k/powerlevel10k", "agnoster"
ZSH_THEME="robbyrussell"

# possible values: "disabled", "auto", "reminder"
zstyle ':omz:update' mode auto

# possible values: "1", "3", "7" (in days)
zstyle ':omz:update' frequency 1

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# oh-my-zsh plugins
plugins=(evalcache gradle fast-syntax-highlighting zsh-autosuggestions)

# according to https://github.com/zsh-users/zsh-completions/issues/603#issue-373185486, this can't be added as a plugin to omz for the fpath to work correctly
ZSH_CUSTOM="${ZSH_CUSTOM:-"${ZSH:-"${HOME}/.oh-my-zsh"}/custom"}"
is_directory "${ZSH_CUSTOM}/plugins/zsh-completions/src" && fpath+="${ZSH_CUSTOM}/plugins/zsh-completions/src"

load_file_if_exists ${ZSH}/oh-my-zsh.sh

# Preferred editor for remote sessions
test -n "${SSH_CONNECTION}" && export EDITOR="vi"

command_exists vi && test -z "${EDITOR}" && export EDITOR="vi"

# Compilation flags
[[ "${ARCH}" =~ "x86" ]] && export ARCHFLAGS="-arch x86_64"

load_file_if_exists "${HOME}/.zshrc.custom"

# remove duplicates from some env vars
typeset -gU cdpath CPPFLAGS cppflags FPATH fpath infopath LDFLAGS ldflags MANPATH manpath PATH path PKG_CONFIG_PATH

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="${HOME}/.sdkman"
[[ -s "${HOME}/.sdkman/bin/sdkman-init.sh" ]] && source "${HOME}/.sdkman/bin/sdkman-init.sh"
