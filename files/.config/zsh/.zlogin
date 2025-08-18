#!/usr/bin/env zsh

zcompare() {
  if [[ -s ${1} && ( ! -s ${1}.zwc || ${1} -nt ${1}.zwc) ]]; then
    zcompile ${1}
  fi
}

zcompare "${HOME}/.zshenv"
zcompare "${HOME}/.shellrc"
zcompare "${ZDOTDIR}/.zprofile"
zcompare "${ZDOTDIR}/.zshrc"
zcompare "${ZDOTDIR}/.zlogin"
zcompare "${ZDOTDIR}/.p10k.zsh"

config_files=(
  "aliases.zsh"
  "completions.zsh"
  "functions.zsh"
  "history.zsh"
  "options.zsh"
  "zinit.zsh"
)

for config in "${config_files[@]}"; do
  zcompare "${ZDOTDIR}/config/${config}"
done
