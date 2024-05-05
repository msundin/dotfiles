# Start SSH Agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    eval "$(ssh-agent -s)"
fi

# Used only for Lunarvim?
export PATH=$HOME/.local/bin:$PATH

if [[ "$(uname)" == "Darwin" ]]; then
  ### Commands specific to macOS

  # Homebrew
  if [ -d "/opt/homebrew/bin/" ]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

else
  ### Commands specific elsewhere, e.g. Linux

  # Gnome keyring
  if [ -n "$DESKTOP_SESSION" ]; then
    eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
    export SSH_AUTH_SOCK
  fi
fi


