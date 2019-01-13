#
# .bashrc
#
# Author:
#	Paul Meffle
#
# Summary:
#	My personal bash configuration
#
# License:
#	MIT license

# Enable colors
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Common aliases
alias cl='clear'

# Git aliases
alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gb='git branch'
alias gj='git checkout'
alias gr='git rebase'
alias gm='git merge'
alias gp='git push'
alias gf='git fetch'
alias gl='git log --graph --abbrev-commit'

# Common variables
export PS1="\u \w\n$ "
export EDITOR=vim
