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

load_file_if_exists "${HOME}/.aliases"

path_add "${PERSONAL_BIN_DIR}"

if is_macos && command_exists brew; then
  export MANPATH="${HOMEBREW_PREFIX}/share/man:$(manpath)"
  export INFOPATH="${HOMEBREW_PREFIX}/share/info${INFOPATH+:$INFOPATH}"

  export HOMEBREW_NO_ANALYTICS=1
  export HOMEBREW_CLEANUP_MAX_AGE_DAYS=3
  export HOMEBREW_CLEANUP_PERIODIC_FULL_DAYS=3
  export HOMEBREW_BAT=1
  export HOMEBREW_VERBOSE_USING_DOTS=1
  export HOMEBREW_CASK_OPTS="--no-quarantine"

  command_exists mise && _evalcache mise activate zsh

# command_exists direnv && _evalcache direnv hook zsh

# load_file_if_exists "${HOME}/.config/devbox/lib/use_devbox.sh"

CURL_DIR="${HOMEBREW_PREFIX}/opt/curl"
path_add "${CURL_DIR}/bin" before
fi

if is_macos; then
  # setopt glob_dots                # no special treatment for file names with a leading dot
  # setopt no_auto_menu             # require an extra TAB press to open the completion menu
  # setopt auto_menu                # automatically use menu completion
  # setopt list_beep
  # setopt correct_all              # autocorrect commands; also enables arguments autocorrect
  # setopt always_to_end            # move cursor to end if word had one match

  setopt append_history
  setopt share_history            # share history between different instances of the shell
  setopt inc_append_history       # append command to history file immediately after execution
  setopt extended_history         # save each command's beginning timestamp and the duration to the history file
  setopt hist_ignore_all_dups     # do not put duplicated command into history list
  setopt hist_ignore_dups
  setopt hist_allow_clobber
  setopt hist_reduce_blanks       # remove unnecessary blanks
  setopt hist_save_no_dups        # do not save duplicated command
  setopt auto_cd                  # cd into directory if the name is not an alias or function, but matches a directory
  setopt auto_pushd               # Make cd push the old directory onto the directory stack.
  setopt pushd_silent             # Do not print the directory stack after pushd or popd.
  setopt pushd_ignore_dups        # Don’t push multiple copies of the same directo
  setopt beep
  setopt extended_glob
  setopt local_options
  setopt auto_list                # Automatically list choices on an ambiguous completion.
  setopt list_ambiguous
  setopt list_types               # If the file being listed is a directory, show a trailing slash

  # console colors
  autoload -U colors && colors
fi

### Fix slowness of pastes with zsh-syntax-highlighting.zsh
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic
}

pastefinish() {
  zle -N self-insert "${OLD_SELF_INSERT}"
}

zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
### Fix slowness of pastes

# Use bat to colorize man pages
command_exists bat && export MANPAGER="sh -c 'col -bx | bat -l man -p'"

command_exists _awsp && alias awsp="source _awsp"

# iTerm2 shell integrations
load_file_if_exists "${HOME}/.iterm2_shell_integration.zsh"

# remove empty components to avoid '::' ending up + resulting in './' being in $PATH, etc
path=( "${path[@]:#}" )
fpath=( "${fpath[@]:#}" )
infopath=( "${infopath[@]:#}" )
manpath=( "${manpath[@]:#}" )
# path_clean

# remove duplicates from some env vars
typeset -gU cdpath CPPFLAGS cppflags FPATH fpath infopath LDFLAGS ldflags MANPATH manpath PATH path PKG_CONFIG_PATH

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="${HOME}/.sdkman"
[[ -s "${HOME}/.sdkman/bin/sdkman-init.sh" ]] && source "${HOME}/.sdkman/bin/sdkman-init.sh"
