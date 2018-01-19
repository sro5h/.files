#!/usr/bin/env bash

# enable vi like input
set -o vi

# Enable colors
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# ls
alias l='ls -1 --color=auto -h --group-directories-first'
alias la='ls -a1 --color=auto -h --group-directories-first'
alias ll='ls -al --color=auto -h --group-directories-first'

# cd
alias ..='cd ..'

# clear
alias cl='clear'

# git
alias gs='git status'
alias ga='git add'
alias gc='git commit -v'
alias gcm='git commit -m'
alias gj='git checkout'
alias gp='git push'
alias gd='git diff'
alias gm='git merge'
alias gb='git branch'
alias gt='git tag'
alias gl='git log --graph --all --abbrev-commit'

# premake
alias pmake='premake5'

# alert
# usage: [command]; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Get current branch in git repo
function git_branch() {
        BRANCH=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
        if [ ! "${BRANCH}" == "" ]; then
                echo "(${BRANCH}) "
        else
                echo ""
        fi
}

# Prompt colors
colorClear="\[\e[m\]"
colorUser="\[\e[30;45m\]"
colorLightSep="\[\e[35;100m\]"
colorCwd="\[\e[97;100m\]"
colorBranch="\[\e[37;100m\]"
colorDarkSep="\[\e[37m\]"

# Custom prompt ' user > host > branch >'
export PS1="\n${colorUser} \u ${colorClear}${colorLightSep}>${colorClear}${colorCwd} \W ${colorClear}${colorBranch}\`git_branch\`${colorClear}${colorDarkSep}>${colorClear} "

# Enable git completion
if [ -f /usr/share/bash-completion/completions/git ]; then
        source /usr/share/bash-completion/completions/git
fi

# Author.: Ole J
# Wraps a completion function
# make-completion-wrapper <actual completion function> <name of new func.>
#                         <command name> <list supplied arguments>
# eg.
#   alias agi='apt-get install'
#   make-completion-wrapper _apt_get _apt_get_install apt-get install
# defines a function called _apt_get_install (that's $2) that will complete
# the 'agi' alias. (complete -F _apt_get_install agi)
#
function make-completion-wrapper () {
        local function_name="$2"
        local arg_count=$(($#-3))
        local comp_function_name="$1"
        shift 2
        local function="function $function_name {
                ((COMP_CWORD+=$arg_count))
                COMP_WORDS=( "$@" \${COMP_WORDS[@]:1} )
                "$comp_function_name"
                return 0
        }"
        eval "$function"
}

# We create a _git_checkout_mine function that will do the completion for "gco"
# using the completion function "_git"
make-completion-wrapper _git _git_checkout_mine git checkout
make-completion-wrapper _git _git_push_mine git push
make-completion-wrapper _git _git_merge_mine git merge

# We tell bash to actually use _git_checkout_mine to complete "gco"
complete -o bashdefault -o default -o nospace -F _git_checkout_mine gj
complete -o bashdefault -o default -o nospace -F _git_push_mine gp
complete -o bashdefault -o default -o nospace -F _git_merge_mine gm

# ls colors
export LS_COLORS='di=34:fi=0:ln=36:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=32:*.rpm=90'

# Use vim as editor
export EDITOR=vim

# Android studio
if [ -d "$HOME/Android/Sdk/" ]; then
        PATH="$PATH:$HOME/Android/Sdk/platform-tools:$HOME/Android/Sdk/emulator"
fi

# Rust binaries
if [ -d "$HOME/.cargo/bin/" ]; then
        PATH="$PATH:$HOME/.cargo/bin"
fi
