# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="avit"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

## zsh-vi-mode plugin
# NOTE: Has to be placed before the 'ZVM_INIT_MODE=sourcing', otherwise 'jk' will not work
# Bind jk to ESC
# ZVM_VI_INSERT_ESCAPE_BINDKEY='jk'

# NOTE: Without this zsh-vi-mode plugin breaks command history search CTRL-R, enabled by fzf plugin
# NOTE: zsh-vi-mode also has to be placed before fzf amongst the plugins
ZVM_INIT_MODE=sourcing

plugins=(
#  zsh-vi-mode
#  zsh-syntax-highlighting
  history-substring-search
  colored-man-pages
  ## Seems lik it conflicts with SPACE+TAB in zoxide https://github.com/marlonrichert/zsh-autocomplete/issues/706
  # zsh-autosuggestions
  ## Use zoxide, installed via paru/brew, instead of z
  # z
  emoji
  sudo
  web-search
  copypath
  copyfile
  copybuffer
  history
  jsontools
  git
  gh
  fzf
  # jira
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Bash scripts
export PATH=$HOME/scripts/bash:$HOME/scripts/bash/media/:$PATH

# Increase number of file descriptors
ulimit -n 4096

eval "$(zoxide init --cmd cd zsh)"
# eval "$(zoxide init zsh)"

export RANGER_LOAD_DEFAULT_RC="false"
# Enable vi-mode
bindkey -v

zle -N vi-paste-from-clipboard
bindkey -M vicmd 'p' vi-paste-from-clipboard

# set jk to ESC
# bindkey -M viins 'jk' vi-cmd-mode
# Set Backspace key to delete the character behind the cursor
# bindkey '^?' backward-delete-char

case "$TERM" in
  alacritty)
    export TERM="xterm-256color"
    ;;
esac

if [[ "$(uname)" == "Darwin" ]]; then
  ### Commands specific to macOS

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

  # To be able to run X11 applications (like feh) on Mac with xQuartz
  export DISPLAY=:0

  export PATH=$HOME/.local/bin:$PATH

  function vi-yank-to-clipboard() {
    # Copy the entire current line to the clipboard
    print -n "$BUFFER" | pbcopy
  }
  
  function vi-paste-from-clipboard() {
    # echo "Attempting to paste from clipboard..." >> /tmp/zsh_debug.log
    local clipboard_content=$(pbpaste)
    # echo "Clipboard content: $clipboard_content" >> /tmp/zsh_debug.log
    LBUFFER="$LBUFFER$clipboard_content"
    zle redisplay
  }

  # Set $JAVA_HOME to the currently user by sdkman
  export JAVA_HOME=$HOME/.sdkman/candidates/java/current/

  # Set Android SDK path
  export PATH=$PATH:~/Library/Android/sdk/platform-tools

  # Alias to refresh Artifactory OIDC token
  alias refresh-artifactory-token='~/TokenUpdater/TokenUpdater refresh && awk '\''/machine ara-artifactory.volvocars.biz/{flag=1;next}/machine/{flag=0}flag && $1 == "password" {print "ARTIFACTORY_OIDC_TOKEN=" $2}'\'' ~/.netrc'

else
  ### Commands specific elsewhere, e.g. Linux

  alias -s {png,jpg}=feh
  alias -s {pdf}=brave

  # /etc etckeeper helpers
  etcgit() { sudo -E git -C /etc "$@"; }
  
  # completions like normal git
  compdef _git etcgit=git
  
  # quick views
  etcstatus() { etcgit status; }
  etclog()    { etcgit log --oneline --decorate --graph -n 20; }
  etcdiff()   { etcgit -c color.ui=always log -p -n 1; }  # last change

  function vi-yank-to-clipboard() {
    # Copy the entire current line to the clipboard
    print -n "$BUFFER" | xclip -selection clipboard
  }
  
  function vi-paste-from-clipboard() {
    # echo "Attempting to paste from clipboard..." >> /tmp/zsh_debug.log
    local clipboard_content=$(xclip -selection clipboard -o)
    # echo "Clipboard content: $clipboard_content" >> /tmp/zsh_debug.log
    LBUFFER="$LBUFFER$clipboard_content"
    zle redisplay
  }

fi

# Bind the function to vi command mode keybinding
zle -N vi-yank-to-clipboard
bindkey -M vicmd 'yy' vi-yank-to-clipboard

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# alias rm='echo "use trash instead"; false'
alias zshconfig='v ~/.zshrc'
alias ohmyzsh='v ~/.oh-my-zsh'
alias tmux='TERM=screen-256color tmux'
alias clip='xclip -selection clipboard'
alias cl='clear'
alias yt='yt-dlp'

alias l='lazygit'
alias f='fzf'

alias cf='copyfile'
alias ch='copypath'

# Obsidian
alias ow='cd ~/obsidian-vaults/work/'
alias op='cd ~/obsidian-vaults/personal/'
alias od='cd ~/obsidian-vaults/dev/'
alias or='v $(pwd)/inbox/*.md'

alias nvim='nvim' # default Neovim config
alias v='NVIM_APPNAME=nvim-lazyvim nvim' # LazyVim
alias vz='NVIM_APPNAME=nvim-lazyvim nvim' # LazyVim
alias vc='NVIM_APPNAME=nvim-nvchad nvim' # NvChad
alias vk='NVIM_APPNAME=nvim-kickstart nvim' # Kickstart
alias va='NVIM_APPNAME=nvim-astrovim nvim' # AstroVim
alias vl='NVIM_APPNAME=lvim lvim' # LunarVim

export SUDO_EDITOR=~/scripts/bash/nvim-lazyvim

# Find and open files by filename
fv() {
  local file
  file=$(fzf --preview 'bat --style=numbers --color=always {} 2>/dev/null || cat {}' --preview-window=right:60%:wrap --filepath-word --multi) && v "${file[@]}"
}

# Find and open files by content
fvg() {
  local file
  file=$(rg --hidden --no-ignore --glob=!.git/ --line-number --no-heading --color=always --smart-case "$1" | 
    fzf --ansi --preview 'bat --style=numbers --color=always $(echo {} | cut -d ":" -f1) --highlight-line $(echo {} | cut -d ":" -f2)' --preview-window=right:60%:wrap) &&
    nvim $(echo "$file" | cut -d ":" -f1) +$(echo "$file" | cut -d ":" -f2)
}

edit-lazyvim() {
  NVIM_APPNAME=nvim-lazyvim nvim "$@"
}
export EDITOR=edit-lazyvim
export VISUAL=edit-lazyvim
export PATH="$HOME/.local/bin:$PATH"

# Yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Restart Yabai

# Define a function instead of an alias
yr() {
  touch /tmp/yabai_softrestart_flag
  echo "Created /tmp/yabai_softrestart_flag before service restart"
  
  # Restart yabai services
  yabai --stop-service && yabai --start-service
  
  # Remove the temporary file
  # Sleep needed, otherwise the file is removed before yabai is run
  sleep 1
  rm /tmp/yabai_softrestart_flag
  echo "Removed /tmp/yabai_softrestart_flag after service restart"
}

yrh() {
  close-mac-apps
  yabai --stop-service && yabai --start-service
}

vv() {
  # Assumes all configs exist in directories named ~/.config/nvim-*
  local config=$(fd --max-depth 1 --glob 'nvim-*' ~/.config | fzf --prompt="Neovim Configs > " --height=~50% --layout=reverse --border --exit-0)

  # If I exit fzf without selecting a config, don't open Neovim
  [[ -z $config ]] && echo "No config selected" && return

  # Open Neovim with the selected config
  NVIM_APPNAME=$(basename $config) nvim $@
}

[ -f ~/.private-aliases.zsh ] && source ~/.private-aliases.zsh

export PATH="$HOME/.local/bin:$PATH"
export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"

[ -f "/home/mattias/.ghcup/env" ] && . "/home/mattias/.ghcup/env" # ghcup-env

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

