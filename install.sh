#!/usr/bin/env bash
set -euo pipefail

# Install Homebrew and setup workspace
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
brew install derailed/k9s/k9s
brew install htop
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting

# Setup dotfiles
DOTFILES_PATH="$HOME/dotfiles"
# Symlink dotfiles to the root within your workspace
find $DOTFILES_PATH -type f -path "$DOTFILES_PATH/.*" |
while read df; do
  link=${df/$DOTFILES_PATH/$HOME}
  mkdir -p "$(dirname "$link")"
  ln -sf "$df" "$link"
done
