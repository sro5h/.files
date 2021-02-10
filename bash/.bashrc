# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Enable colors
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Common aliases
alias cl='clear'
alias pmake='premake5'

# Cd aliases
alias cdr='cd ~/development/repositories'
alias cdp='cd ~/development/projects'

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
export PS1="\u@\h \e[0;34m\w\e[0m\n$ "
export EDITOR=vim

# Custom binaries
if [ -d "${HOME}/.local/bin" ]; then
        PATH="${PATH}:${HOME}/.local/bin"
fi

# Cpp include paths
export CPLUS_INCLUDE_PATH="${CPLUS_INCLUDE_PATH}:/usr/include"
