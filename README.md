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

## Install all common dotfiles

```bash
cd ~/dotfiles/common
# Dry-run
stow -n -v -t ~ *
# Create the common symbolic links at the right place
stow -v -t ~ *
```

## Install all linux dotfiles

```bash
cd ~/dotfiles/linux
# Dry-run
stow -n -v -t ~ *
# Create the linux symbolic links at the right place
stow -v -t ~ *
```

## Install all common dotfiles

```bash
cd ~/dotfiles/mac
# Dry-run
stow -n -v -t ~ *
# Create the mac symbolic links at the right place
stow -v -t ~ *
```
