export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""

plugins=(git git-to-jj)

source $ZSH/oh-my-zsh.sh

# Fnm
eval "$(fnm env --use-on-cd)"

# Starship
eval "$(starship init zsh)"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# sst
export PATH="$HOME/.sst/bin:$PATH"

# go
export GOPATH=$HOME/go
export GOROOT=/opt/homebrew/Cellar/go/$(go version | { read _ _ v _; echo ${v#go}; })/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Bun
export PATH="$HOME/.bun/bin:$PATH"

# opencode
export PATH=$HOME/.opencode/bin:$PATH

# Aliases
alias lg="lazygit"
alias oc="opencode"
alias now="date +\"%Y%m%d%H%M%S\""

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

export PATH="$HOME/.local/bin:$PATH"
