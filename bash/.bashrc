#!/usr/bin/env bash
# ls
alias l='ls -1 --color -h --group-directories-first'
alias la='ls -a1 --color -h --group-directories-first'
alias ll='ls -al --color -h --group-directories-first'

# clear
alias cl='clear'

# git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gh='git checkout'
alias gp='git push'
alias gd='git diff'
alias gm='git merge'
alias gb='git branch'
alias gt='git tag'
alias gl='git log'

# enable vi like input
set -o vi

# get current branch in git repo
function git_branch() {
    BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ ! "${BRANCH}" == "" ]
    then
        echo " (${BRANCH}) "
    else
        echo ""
    fi
}

# custom prompt ' user > host > branch >'
export PS1="\n\[\e[30;42m\] \u \[\e[m\]\[\e[32;47m\]>\[\e[m\]\[\e[97;47m\] \w \[\e[m\]\[\e[37;100m\]>\[\e[m\]\[\e[96;100m\]\`git_branch\`\[\e[m\]\[\e[37m\]>\[\e[m\] "

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
    local function="
function $function_name {
    ((COMP_CWORD+=$arg_count))
    COMP_WORDS=( "$@" \${COMP_WORDS[@]:1} )
    "$comp_function_name"
    return 0
}"
    eval "$function"
}

# we create a _git_checkout_mine function that will do the completion for "gco"
# using the completion function "_git"
make-completion-wrapper _git _git_checkout_mine git checkout
make-completion-wrapper _git _git_push_mine git push
make-completion-wrapper _git _git_merge_mine git merge

# we tell bash to actually use _git_checkout_mine to complete "gco"
complete -o bashdefault -o default -o nospace -F _git_checkout_mine gh
complete -o bashdefault -o default -o nospace -F _git_push_mine gp
complete -o bashdefault -o default -o nospace -F _git_merge_mine gm

# ls colors
LS_COLORS='di=34:fi=0:ln=36:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=32:*.rpm=90'
export LS_COLORS
