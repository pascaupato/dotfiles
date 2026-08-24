#!/bin/zsh
# ===
# zsh personal config for tito
# ===

# ===
# ENV
# ===


# PATH
export PATH="/usr/local/bin:/usr/local/sbin:/opt/local/bin:$PATH"
export PATH="/Users/tito/.local/bin:$PATH"
# obsidian
export PATH="$PATH:/Applications/Obsidian.app/Contents/MacOS"
# homebrew
export PATH="/opt/homebrew/opt/python@2/libexec/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
# rust
export PATH="/Users/tito/.cargo/bin:$PATH"
# go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
# scripts
export XDG_CONFIG_HOME="$HOME/.config"
export PATH="$XDG_CONFIG_HOME/scripts:$PATH"

# use bat as the pager for man and help pages
export MANPAGER="sh -c 'awk '\''{ gsub(/\x1B\[[0-9;]*m/, \"\", \$0); gsub(/.\x08/, \"\", \$0); print }'\'' | bat -p -lman'"
alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

# other
export MANPATH=$MANPATH:/opt/homebrew/share/man
export DOTFILES="$HOME/dotfiles"
export ZSH="$DOTFILES/zshrc"
# Esto pone zsh automáticamente en vi mode.  
export EDITOR="/opt/homebrew/bin/nvim"
export FUNCNEST=100000
# colors in tmux
export TERM="xterm-256color"




# ===
# ALIASES:
# ===

# Dotfiles
alias zshconfig="nvim $ZSH/.zshrc"
alias zshsource="source $ZSH/.zshrc"
alias tmuxconfig="nvim $DOTFILES/tmux/tmux.conf"

# Git
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push origin HEAD"
alias gpu="git pull origin"
alias gst="git status"
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias gdiff="git diff"
alias gco="git checkout"
alias gb='git branch'
alias gba='git branch -a'
alias gadd='git add'
alias ga='git add -p'
alias gcoall='git checkout -- .'
alias gr='git remote'
alias gre='git reset'

# Dirs. Two for parent. One extra for each extra level. 
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# bat
alias cat="bat"

# remote
alias guernika="ssh -p 22 a0495775@guernika.lab.inf.uc3m.es"

# vm
alias utm="utmctl"

# nmap
alias nm="nmap -sC -sV -oN nmap"

# general
alias cl='clear'
alias t="tmux"
alias f="fzf"
alias nv="nvim"
alias ls="lsd"
alias ll="lsd -l"
alias lsa="lsd -la"
alias lst="lsd -t"
alias py="python3"
alias cd="z"

# other
alias findwifipass="security find-generic-password -wa"
alias unixtime="date +%s |pbcopy"


# ===
# PACKAGES:
# ===

# zsh completion system
# NOTE: must run before any tool init below (fzf/zoxide/tv) that registers its own completions via compdef
autoload -Uz compinit
compinit

# fzf
# colors adapt to the terminal theme (fg/bg left as-is), accents for interactive elements
export FZF_DEFAULT_OPTS="--color=fg:-1,bg:-1,fg+:-1,bg+:-1,hl:cyan,hl+:cyan,info:blue,prompt:green,pointer:magenta,marker:yellow,spinner:cyan,header:blue,border:cyan,label:cyan"
eval "$(fzf --zsh)"

# zoxide
eval "$(zoxide init zsh)"

# starship
#   change the default config dir
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
eval "$(starship init zsh)"

# tv 
eval "$(tv init zsh)"

# ===
# PLUGINS:
# - without a package manager
# - using carapace for smarter completions
# - fzf-tab for a boxed/colorized completion menu
# - format the completions manually (:completion*)
# ===

# fzf-tab
# NOTE: must load after compinit, but before plugins that wrap zle widgets (autosuggestions, syntax-highlighting)
source "$(brew --prefix)/share/fzf-tab/fzf-tab.zsh"

# autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# key bindings for autosuggest
bindkey '^w' autosuggest-execute
bindkey '^e' autosuggest-accept
bindkey '^u' autosuggest-toggle
bindkey '^L' vi-forward-word
bindkey '^k' up-line-or-search
bindkey '^j' down-line-or-search

# syntax highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# smarter completions
# NOTE: must be loaded AFTER compinit
export CARAPACE_BRIDGES='zsh'
zstyle ':completion:*' menu select=2
zstyle ':completion:*:descriptions' format '%F{white}[%d]%f'
export LS_COLORS="di=34:fi=15:ln=36:pi=33:so=35:do=33:bd=33:cd=33:ex=32"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
source <(carapace _carapace)

# fzf-tab display: boxed popup, bordered, capped to terminal height
zstyle ':fzf-tab:*' fzf-flags '--border' '--height=40%' '--layout=reverse'
# preview pane for file/dir completions, using the same tools already used elsewhere (lsd, bat)
zstyle ':fzf-tab:complete:*:*' fzf-preview 'if [[ -d $realpath ]]; then lsd --color=always $realpath; elif [[ -f $realpath ]]; then bat --color=always --style=numbers --line-range=:200 $realpath; fi'


# ===
# OTHER:
# ===
# fixing the vi mode
bindkey -v
export KEYTIMEOUT=1
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^H' backward-delete-char
# delete whole line with cmd + backspace
bindkey '^U' backward-kill-line  
