# dotfiles
My dotfiles

Handled with [Stow](https://github.com/aspiers/stow)

Example:

```bash
cd ~/dotfiles/common
# Create a script file
touch scripts/bash/test.sh
# Dry-run
stow -n -v -t ~ shell-scripts
# Create the symbolic links at the right place (~/scripts/bash)
stow -v -t ~ shell-scripts
```
