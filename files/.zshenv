#!/usr/bin/env zsh

skip_global_compinit=1

# https://github.com/sorin-ionescu/prezto/blob/master/runcoms/zshenv
# Ensure that a non-login, non-interactive shell has a defined environment.
export ZDOTDIR="${HOME}"
[[ ( "${SHLVL}" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR}/.zprofile" ]] && source "${ZDOTDIR}/.zprofile"
