#!/usr/bin/env bash
set -euo pipefail

if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
/home/linuxbrew/.linuxbrew/bin/brew install derailed/k9s/k9s
/home/linuxbrew/.linuxbrew/bin/brew install htop
/home/linuxbrew/.linuxbrew/bin/brew install zsh-autosuggestions
/home/linuxbrew/.linuxbrew/bin/brew install zsh-syntax-highlighting

# Setup dotfiles
DOTFILES_PATH="$HOME/dotfiles/dotfiles"
# Symlink dotfiles to the root within your workspace
find $DOTFILES_PATH -type f -path "$DOTFILES_PATH/.*" |
while read df; do
  link=${df/$DOTFILES_PATH/$HOME}
  mkdir -p "$(dirname "$link")"
  ln -sf "$df" "$link"
done

# setup gitconfig
echo "Setting up gitconfig..."
echo " - dd-source"
cat "$DOTFILES_PATH/conf/dd-source_gitconfig" > "$HOME/dd/dd-source/.git/config"

# setup workspaces
echo "Setting up winter..."
setup-repo winter
