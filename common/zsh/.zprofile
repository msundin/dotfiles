# Start SSH Agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    eval "$(ssh-agent -s)"
fi

if [[ "$(uname)" == "Darwin" ]]; then
  ### Commands specific to macOS

  # Homebrew
  if [ -d "/opt/homebrew/bin/" ]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  # Used only for Lunarvim?
  export PATH=$HOME/.local/bin:$PATH
else
  ### Commands specific elsewhere, e.g. Linux
fi

