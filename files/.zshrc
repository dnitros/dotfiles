#!/usr/bin/env zsh

# vim:syntax=zsh
# vim:filetype=zsh

# file location: ${HOME}/.zshrc

# Optimizing zsh: https://htr3n.github.io/2018/07/faster-zsh/

# for profiling zsh, see: https://unix.stackexchange.com/a/329719/27109
zmodload zsh/zprof

load_file_if_exists() {
  test -e "$1" && source "$1" || true
}

command_exists() {
  type $1 &> /dev/null 2>&1
}

# Path to your oh-my-zsh installation.
export ZSH=${HOME}/.oh-my-zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ${HOME}/.zshrc.
load_file_if_exists "${XDG_CACHE_HOME}/p10k-instant-prompt-${USERNAME}.zsh"

load_file_if_exists "${HOME}/.p10k.zsh"
load_file_if_exists "${HOMEBREW_PREFIX}/opt/powerlevel10k/powerlevel10k.zsh-theme"  # intel
load_file_if_exists "${HOMEBREW_PREFIX}/share/powerlevel10k/powerlevel10k.zsh-theme"  # arm

# Set theme to load - possible values "random", "robbyrussell", "powerlevel10k/powerlevel10k", "agnoster"
ZSH_THEME="robbyrussell"

# possible values: "disabled", "auto", "reminder"
zstyle ':omz:update' mode auto

# possible values: "1", "3", "7" (in days)
zstyle ':omz:update' frequency 1

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# oh-my-zsh plugins
plugins=(evalcache gradle zsh-autosuggestions zsh-syntax-highlighting)

load_file_if_exists ${ZSH}/oh-my-zsh.sh

# Preferred editor for remote sessions
test -n "${SSH_CONNECTION}" && export EDITOR="vi"

command_exists vi && test -z "${EDITOR}" && export EDITOR="vi"

# Compilation flags
[[ "${ARCH}" =~ "x86" ]] && export ARCHFLAGS="-arch x86_64"

load_file_if_exists "${HOME}/.zshrc.custom"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="${HOME}/.sdkman"
[[ -s "${HOME}/.sdkman/bin/sdkman-init.sh" ]] && source "${HOME}/.sdkman/bin/sdkman-init.sh"
