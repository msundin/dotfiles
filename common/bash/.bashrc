#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Setting ls alias based on OS type
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS system detected, using BSD ls
  alias ls='ls -G'
else
  # Assuming Linux or other OS with GNU ls
  alias ls='ls --color=auto'
fi

PS1='[\u@\h \W]\$ '

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
