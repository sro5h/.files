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

# Common aliases
alias cl="clear"

# Cd aliases
alias cdd="cd /srv/dev"
alias cdr="cd /srv/dev/repositories"
alias cdp="cd /srv/dev/projects"
alias cds="cd /srv/dev/software"

# Git aliases
alias gs="git status"
alias gd="git diff"
alias gds="git diff --staged"
alias ga="git add"
alias gc="git commit"
alias gb="git branch"
alias gj="git checkout"
alias gr="git rebase"
alias gm="git merge"
alias gp="git push"
alias gf="git fetch"
alias gl="git log --graph --abbrev-commit"

# Meson aliases
alias mb="meson build"
alias mc="meson compile -C build"
alias mt="meson test -C build"
alias mr="meson compile --clean -C build && meson compile -C build"

# Zig aliases
alias zb="zig build"

# Common variables
export EDITOR=vim

# Prompt
user="\[\e[0;95m\]\u\[\e[0m\]"
at="\[\e[0;96m\]@\[\e[0m\]"
host="\[\e[0;94m\]\h\[\e[0m\]"
directory="\[\e[0;96m\]\W\[\e[0m\]"
sign="\[\e[0;96m\]\$\[\e[0m\]"
export PS1="$user$at$host $directory $sign "

# Custom binaries
if [ -d "${HOME}/.local/bin" ]; then
        PATH="${PATH}:${HOME}/.local/bin"
fi

# Cpp include paths
CPLUS_INCLUDE_PATH="${CPLUS_INCLUDE_PATH}:/usr/include"
