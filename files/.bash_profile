#!/usr/bin/env bash

type load_file_if_exists &> /dev/null 2>&1 || source "${HOME}/.shellrc"

load_file_if_exists "${HOME}/.bashrc"

path_add "${HOME}/bin" before
path_add "${HOME}/.local/bin" before
