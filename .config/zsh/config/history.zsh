#!/usr/bin/env zsh

HISTFILE_DIR="${XDG_STATE_HOME}/zsh"
HISTFILE="${HISTFILE_DIR}/history"
! is_directory "${HISTFILE_DIR}" && mkdir -p ${HISTFILE_DIR}
HISTSIZE=20000
SAVEHIST=10000
