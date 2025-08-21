#!/usr/bin/env zsh

alias path='echo -e ${PATH//:/\\n}'
if command_exists nvim; then
  alias vi='nvim'
elif command_exists vim; then
  alias vi='vim'
fi
if command_exists eza; then
  alias ls='eza --icons'
  alias tree='eza --icons -T -L 3'
else
  alias ls='ls --color'
fi
command_exists bat && alias cat='bat'
command_exists btop && alias top='btop'
command_exists _awsp && alias awsp="source _awsp"

alias code-gist='code ${DOTFILES_DIR} ${HOME}/.gitconfig.d/* ${HOME}/.gitignore'

# brew aliases
if command_exists brew; then
  alias bcg='brew outdated --greedy'
  alias bcug='brew upgrade --greedy'
  alias bupc='brew bundle check || brew bundle --all --cleanup; brew bundle cleanup -f --zap; brew cleanup --prune=all; brew autoremove; brew upgrade'
fi

# colima and docker
if command_exists colima; then
  alias clst='colima start -c 6 -m 8 && echo "Please approve for creating softlink to /var/run/docker.sock" && sudo ln -sf ${XDG_CONFIG_HOME}/colima/default/docker.sock /var/run/docker.sock'
  alias clstp='colima stop && echo "Please approve to remove softlink /var/run/docker.sock" && sudo rm /var/run/docker.sock'
fi

if command_exists docker; then
  alias docker_cleanup='docker system prune --volumes -f'
  alias docker_list='docker ps -a && docker images'
fi
