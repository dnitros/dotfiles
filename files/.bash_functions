#!/usr/bin/env bash

# Prompt colors
COLOR256=()
COLOR256[0]="${RED}"
COLOR256[256]="${NO_COLOR}"
COLOR256[257]="${BOLD}"

PROMPT_COLORS=()

set_prompt_colors() {
  local h=${1:-0}
  local color=
  local i=0
  local j=0
  for i in {22..231}; do
    ((i % 30 == h)) || continue

    color=${COLOR256[$i]}
    # cache the tput colors
    if [[ -z $color ]]; then
    COLOR256[$i]=$(tput setaf "$i")
    color=${COLOR256[$i]}
    fi
    PROMPT_COLORS[$j]=$color
    ((j++))
  done
}

# Prompt command
_prompt_command() {
  local user=$USER
  local host=${HOSTNAME%%.*}
  local pwd=${PWD/#$HOME/\~}
  local ssh=
  is_non_zero_string "${SSH_CLIENT}" && ssh='[ssh] '
  printf "\033]0;%s%s@%s:%s\007" "$ssh" "$user" "$host" "$pwd"
}

# Print all 256 colors
colors() {
  local i
  for i in {0..255}; do
    printf "\x1b[38;5;${i}mcolor %d\n" "$i"
  done
  tput sgr0
}

SKIP_CONFIRMATION=${SKIP_CONFIRMATION:-false}
INSTALL_K3S=${INSTALL_K3S:-true}

dep_update() {
  manage_apt_packages
  install_or_update_k3s
}

manage_apt_packages() {
  info "📦 Checking for APT updates and installing from .packages"

  info "🔍 Updating package list..."
  sudo apt-get update -qq

  info "📋 Checking for upgradable packages..."
  UPGRADABLE=$(apt list --upgradable 2>/dev/null | grep -v "Listing" || true)

  if is_non_zero_string "$UPGRADABLE"; then
    info "🔄 Upgradable packages detected:"
    echo "$UPGRADABLE" | awk '{print "  ⬆️ " $1}'
    if _confirm_action "⚠️  Do you want to upgrade all packages?"; then
      sudo apt-get upgrade -y
    else
      warn "⏭️  Skipped upgrade"
    fi
  else
    success "✅ All packages are up to date"
  fi

  if is_file "${HOME}/.packages"; then
    info "📦 Ensuring required packages from .packages are installed..."
    xargs -a "${HOME}/.packages" sudo apt-get install -y -q
  else
    warn "⚠️  No .packages file found at ${HOME}/.packages"
  fi
}

install_or_update_k3s() {
  if ! _verify_binary_update "k3s" INSTALL_K3S "k3s-io/k3s" "k3s --version | head -n1 | awk '{print \$3}'"; then
    return
  fi

  local latest="$BINARY_LATEST_VERSION"

  if _confirm_action "⚠️  Proceed to install/update k3s $latest?"; then
    curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION="$latest" K3S_KUBECONFIG_MODE=644 sh -s - --disable traefik --disable servicelb || {
      error "❌ Failed to install/update k3s"
      return
    }
    success "✅ k3s installed/updated to version $latest"
  else
    warn "⏭️  Skipped k3s install/update"
  fi
}

_confirm_action() {
  local prompt="$1"
  if [[ "$SKIP_CONFIRMATION" == true ]]; then
    return 0
  fi
  read -rp "$prompt [y/N]: " confirm
  [[ "$confirm" =~ ^[Yy]$ ]]
}

_verify_binary_update() {
  local binary_name="$1"
  local install_flag_name="$2"
  local install_flag_value="${!2}"
  local repo="$3"
  local current_version_fetch_cmd="$4"

  [[ "$install_flag_value" != true ]] && {
    warn "⚠️  Skipping $binary_name installation (${install_flag_name}=${install_flag_value})"
    return 1
  }

  local latest
  latest=$(curl -fsSL "https://api.github.com/repos/${repo}/releases/latest" |
           grep -oE '"tag_name"\s*:\s*"[^"]+"' |
           sed -E 's/^"tag_name"\s*:\s*"([^"]+)"$/\1/' |
           grep -E '[0-9]+\.[0-9]+\.[0-9]+')

  [[ -z "$latest" ]] && {
    error "❌ Failed to fetch latest $binary_name version"
    return 1
  }

  if command_exists "$binary_name"; then
    local current
    current=$(eval "$current_version_fetch_cmd")
    if [[ "$current" == "$latest" ]]; then
      success "✅ $binary_name is up to date ($current)"
      return 1
    else
      info "🔄 Updating $binary_name: $current → $latest"
    fi
  else
    info "⬇️ Installing $binary_name $latest"
  fi

  export BINARY_LATEST_VERSION="$latest"
  return 0
}
