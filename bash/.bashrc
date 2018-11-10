#!/usr/bin/env bash

# Enable colors
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# cd
alias ..='cd ..'

# clear
alias cl='clear'

# git
alias gs='git status'
alias ga='git add'
alias gc='git commit -v'
alias gj='git checkout'
alias gp='git push'
alias gd='git diff'
alias gm='git merge'
alias gb='git branch'
alias gr='git rebase'
alias gt='git tag'
alias gl='git log --graph --abbrev-commit'

# premake
alias pmake='premake5'

# Prompt colors
colorLightGreen="\[\e[92m\]"
colorLightBlue="\[\e[94m\]"
colorClear="\[\e[m\]"

# Prompt string
export PS1="${colorLightGreen}\u${colorClear}:${colorLightBlue}\w${colorClear}$ "

# ls colors
export LS_COLORS='di=94:fi=0:ln=96:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=32:*.rpm=90'

# Use vim as editor
export EDITOR=vim

# Android studio
if [ -d "$HOME/Android/Sdk/" ]; then
        PATH="$PATH:$HOME/Android/Sdk/platform-tools:$HOME/Android/Sdk/emulator"
fi

# Custom binaries
if [ -d "$HOME/.bin/" ]; then
        PATH="$PATH:$HOME/.bin"
fi
