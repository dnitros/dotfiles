#!/usr/bin/env zsh

symlink() {
	printf '%55s -> %s\n' "${1/#$HOME/~}" "${2/#$HOME/~}"
	ln -nsf "$@"
}

FILES="${DOTFILES_DIR}/files"

for entry in "$FILES"/* "$FILES"/.[!.]*
do
  basename_entry=$(basename "$entry")
  [[ -d ${HOME}/$basename_entry && ! -L ${HOME}/$basename_entry ]] && rm -r "${HOME:?}/$basename_entry"
  symlink "$FILES/$basename_entry" "${HOME}/$basename_entry"
done
