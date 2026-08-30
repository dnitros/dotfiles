#!/usr/bin/env zsh

AWS_PROFILE_FILE="$HOME/.aws/active_profile"

# Auto-load persisted profile on every new session
if [ -f "$AWS_PROFILE_FILE" ]; then
  export AWS_PROFILE=$(cat "$AWS_PROFILE_FILE")
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
  if [ -n "$profile" ]; then
    export AWS_PROFILE="$profile"
    echo "$profile" > "$AWS_PROFILE_FILE"
    echo "✓ Active profile set to: $AWS_PROFILE"
  fi
}

# Clear the persisted AWS profile
awsc() {
  unset AWS_PROFILE
  rm -f "$AWS_PROFILE_FILE"
  echo "✓ AWS profile cleared"
}

idea() {
    if ! type -p idea &>/dev/null; then
        echo "Error: 'idea' command not found."
        return 1
    fi

    if [[ $# -eq 0 ]]; then
        echo "Usage: idea <project-directory>"
        return 1
    fi

    if ! is_directory "${1}"; then
        echo "Error: directory not found: $1"
        return 1
    fi

    nohup command idea "$@" >/dev/null 2>&1 &
}
