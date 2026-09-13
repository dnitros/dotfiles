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
