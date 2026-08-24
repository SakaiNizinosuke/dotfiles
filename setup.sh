#!/usr/bin/env bash

set -Eeuo pipefail

readonly DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "Error: this setup supports macOS only." >&2
  exit 1
fi

if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

echo "Installing Homebrew packages..."
brew bundle --file="$DOTFILES_DIR/Brewfile.brew"
brew bundle --file="$DOTFILES_DIR/Brewfile.cask"

clone_if_missing() {
  local repository="$1"
  local destination="$2"

  if [[ -e "$destination" ]]; then
    echo "Already present: $destination"
  else
    echo "Cloning $repository..."
    git clone --depth=1 "$repository" "$destination"
  fi
}

clone_if_missing https://github.com/ohmyzsh/ohmyzsh.git \
  "$HOME/.oh-my-zsh"
clone_if_missing https://github.com/romkatv/powerlevel10k.git \
  "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
clone_if_missing https://github.com/zsh-users/zsh-autosuggestions.git \
  "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
clone_if_missing https://github.com/zsh-users/zsh-syntax-highlighting.git \
  "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
clone_if_missing https://github.com/tmux-plugins/tpm.git \
  "$HOME/.tmux/plugins/tpm"

echo "Linking dotfiles with GNU Stow..."
cd "$DOTFILES_DIR"
stow --target="$HOME" --restow zsh tmux nvim

echo "Installing tmux plugins..."
"$HOME/.tmux/plugins/tpm/bin/install_plugins"

echo
echo "Setup complete. Start a new shell with: exec zsh"

