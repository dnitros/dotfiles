#!/usr/bin/env bash

type load_file_if_exists &> /dev/null 2>&1 || source "${HOME}/.shellrc"

load_file_if_exists "${HOME}/.bashrc"