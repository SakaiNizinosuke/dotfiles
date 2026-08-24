# Enable Powerlevel10k instant prompt. 
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Homebrew
[[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

typeset -U path PATH

# User local bin
[[ -d "$HOME/.local/bin" ]] && path=("$HOME/.local/bin" $path)

# local tool environment
[[ -f "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env"

# Oh My Zsh
export ZSH="${ZSH:-$HOME/.oh-my-zsh}"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
	git
	zsh-autosuggestions
	web-search
	zsh-syntax-highlighting
)

if [[ -f "$ZSH/oh-my-zsh.sh" ]]; then
	source "$ZSH/oh-my-zsh.sh"
else
	print -u2 "Oh My Zsh is not installed. Run ~/dotfiles/setup.sh."
fi

# Powerlevel10k
[[ -f "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"

# zoxide
if command -v zoxide >/dev/null 2>&1; then
	eval "$(zoxide init zsh)"
	alias cd="z"
fi

# fzf
if command -v fzf >/dev/null 2>&1; then
	eval "$(fzf --zsh)"
fi

export EDITOR="nvim"
export VISUAL="nvim"

alias ls="eza --icons=always"
alias ll="eza -la --icons=always"
