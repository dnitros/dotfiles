#!/usr/bin/env bash

type load_file_if_exists &> /dev/null 2>&1 || source "${HOME}/.shellrc"

# If not running interactively, don't do anything
is_non_zero_string $PS1 || return

# Ensure this script runs only in Bash
[[ "$BASH_VERSION" ]] || return

# Set environment
export EDITOR='vim'
export GREP_COLOR='1;36'
export HISTCONTROL='ignoredups'
export HISTSIZE=5000
export HISTFILESIZE=5000
export LSCOLORS='ExGxbEaECxxEhEhBaDaCaD'
export PAGER='less'
export TZ='Asia/Kolkata'
export VISUAL='vim'

# Set locale
export LANG='en_US.UTF-8'
export LANGUAGE='en_US'
export LC_COLLATE='en_US.UTF-8'
export LC_CTYPE='en_US.UTF-8'
export LC_MESSAGES='en_US.UTF-8'
export LC_MONETARY='en_US.UTF-8'
export LC_NUMERIC='en_US.UTF-8'
export LC_TIME='en_US.UTF-8'
export LESSCHARSET='utf-8'

# XDG Base Directory Specification
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"

# Dotfiles location
export DOTFILES_DIR="${HOME}/.dotfiles"

# Support colors in less
export LESS_TERMCAP_mb=$(tput bold; tput setaf 1)
export LESS_TERMCAP_md=$(tput bold; tput setaf 1)
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_se=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4)
export LESS_TERMCAP_ue=$(tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 2)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)

# Shell Options
shopt -s autocd
shopt -s cdspell
shopt -s checkwinsize
shopt -s dirspell
shopt -s extglob
shopt -s histappend

# Prompt
PS1='$(ret=$?;(($ret!=0)) && echo "\[${COLOR256[0]}\]($ret) \[${COLOR256[256]}\]")'
PS1+='\[${PROMPT_COLORS[0]}\]\[${COLOR256[257]}\]$(((UID==0)) && echo "\[${COLOR256[0]}\]")\u\[${COLOR256[256]}\] - '
PS1+='\[${COLOR256[0]}\]\[${COLOR256[257]}\]'"$(zonename 2>/dev/null | grep -q '^global$' && echo 'GZ:')"'\[${COLOR256[256]}\]'
PS1+='\[${PROMPT_COLORS[3]}\]\h '
PS1+='\[${PROMPT_COLORS[2]}\]'"$(uname | tr '[:upper:]' '[:lower:]')"' '
PS1+='\[${PROMPT_COLORS[5]}\]\w '
PS1+='$(branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null); is_non_zero_string "$branch" && echo "\[${PROMPT_COLORS[2]}\](\[${PROMPT_COLORS[3]}\]git:$branch\[${PROMPT_COLORS[2]}\]) ")'
PS1+='\[${PROMPT_COLORS[0]}\]\$\[${COLOR256[256]}\] '

# Themes: 0-29
set_prompt_colors 24

PROMPT_COMMAND=_prompt_command
PROMPT_DIRTRIM=6

# Load external files
load_file_if_exists "${HOME}/.bash_aliases"
load_file_if_exists "${HOME}/.bashrc.local"

# load completion
if ! shopt -oq posix; then
    for file in \
        /usr/share/bash-completion/bash_completion \
        /etc/bash_completion \
        "${HOME}/.bash_completion"; do
        load_file_if_exists "$file"
    done
fi
