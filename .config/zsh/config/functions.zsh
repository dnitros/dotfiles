#!/usr/bin/env zsh

AWS_PROFILE_FILE="$HOME/.aws/active_profile"

# Auto-load persisted profile on every new session
if is_file "$AWS_PROFILE_FILE"; then
  AWS_PROFILE=$(cat "$AWS_PROFILE_FILE")
  export AWS_PROFILE
fi

# Switch AWS profile
awss() {
  local profile
  profile=$(aws configure list-profiles \
    | fzf --prompt="Select AWS Profile: " \
    --height=~10 \
    --layout=reverse \
    --border=rounded \
    --min-height=5)
  if is_non_zero_string "$profile"; then
    export AWS_PROFILE="$profile"
    echo "$profile" > "$AWS_PROFILE_FILE"
    success "Active profile set to: $AWS_PROFILE"
  fi
}

# Clear the persisted AWS profile
awsc() {
  unset AWS_PROFILE
  rm -f "$AWS_PROFILE_FILE"
  success "AWS profile cleared"
}

# Create an extra Claude account dir (~/.claude-<name>) seeded from ~/.claude.
# Use it by exporting CLAUDE_CONFIG_DIR in a directory's .envrc (direnv).
claude-init() {
  local name="$1" src="$HOME/.claude"
  if [[ ! "$name" =~ ^[A-Za-z0-9_-]+$ ]]; then
    echo "Usage: claude-init <name>   (letters, digits, _ and - only)"
    return 1
  fi

  local dest="$HOME/.claude-$name"
  if is_directory "$dest"; then
    error "$dest already exists"
    return 1
  fi
  mkdir -p "$dest"

  if read -q "?Seed from $src (copy CLAUDE.md and settings.json; symlink skills, agents, commands, hooks, plugins)? [y/N] "; then
    echo
    local f d
    for f in CLAUDE.md settings.json; do
      [[ -e "$src/$f" ]] && cp -L "$src/$f" "$dest/$f"
    done
    for d in skills agents commands hooks plugins; do
      [[ -e "$src/$d" ]] && ln -s "$src/$d" "$dest/$d"
    done
  else
    echo
  fi

  success "Created $dest"
  echo "Add to the parent directory's .envrc, then run 'direnv allow' there:"
  echo "  export CLAUDE_CONFIG_DIR=\"$dest\""
  echo "Then run 'claude' in that directory and /login."
}

idea() {
    if ! command_exists idea; then
        error "'idea' command not found."
        return 1
    fi

    if [[ $# -eq 0 ]]; then
        echo "Usage: idea <project-directory>"
        return 1
    fi

    if ! is_directory "${1}"; then
        error "directory not found: $1"
        return 1
    fi

    nohup command idea "$@" >/dev/null 2>&1 &
}

claude() {
  if ! command_exists claude; then
    error "'claude' command not found."
    return 1
  fi

  if [[ "${PWD}" == "${HOME}/dev/dnitros/"* ]]; then
    command claude --permission-mode bypassPermissions "$@"
  else
    command claude "$@"
  fi
}
