#
# .bashrc
#
# Author:
#       Paul Meffle
#
# Summary:
#       My personal bash configuration
#
# License:
#       MIT license

# Enable colors
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Common aliases
alias cl='clear'
alias pmake='premake5'

# Cd aliases
alias cdr='cd ~/development/repositories'
alias cdp='cd ~/development/projects'
alias cdl='cd ~/development/libraries'

# Git aliases
alias gs='git status'
alias gd='git diff'
alias gds='git diff --staged'
alias ga='git add'
alias gc='git commit'
alias gb='git branch'
alias gj='git checkout'
alias gr='git rebase'
alias gm='git merge'
alias gp='git push'
alias gf='git fetch'
alias gl='git log --graph --abbrev-commit'

# Meson aliases
alias mb='meson build'
alias mc='meson compile -C build'
alias mt='meson test -C build'
alias mr='meson compile --clean -C build && meson compile -C build'

# Common variables
export PS1="\u \e[0;34m\w\e[0m\n$ "
export EDITOR=vim

# Custom binaries
if [ -d "${HOME}/.local/bin" ]; then
        PATH="${PATH}:${HOME}/.local/bin"
fi

# Flutter binaries
if [ -d "${HOME}/.local/bin/flutter/bin" ]; then
        PATH="${PATH}:${HOME}/.local/bin/flutter/bin"
fi

# Cpp include paths
CPLUS_INCLUDE_PATH="${CPLUS_INCLUDE_PATH}:/usr/include"
