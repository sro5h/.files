#! /bin/bash
#
# install.sh: Helper script to stow my dotfiles.
# Author: Paul Meffle

# Global variables
stowTarget="${HOME}"

showUsage() {
        echo "Usage:"
        echo "  install.sh [options]"
        echo ""
        echo "Options:"
        echo "  -I              Install all"
        echo "  -U              Uninstall all"
        echo "  -i <dir>        Install <dir>"
        echo "  -u <dir>        Uninstall <dir>"
}

exists () {
        type "$1" > /dev/null 2>&1
}

install () {
        stow -v -t "${stowTarget}" "${1}"
}
uninstall () {
        stow -v -t "${stowTarget}" -D "${1}"
}

# Check if stow is installed
if ! exists stow; then
        echo "Stow must be installed" >&2
        exit 1
fi

# Parse options
while getopts "hIUi:u:" opt; do
        case ${opt} in
                h)
                        showUsage
                        exit 0
                        ;;
                I)
                        installList=(*/)
                        ;;
                U)
                        uninstallList=(*/)
                        ;;
                i)
                        installList+=("${OPTARG}")
                        ;;
                u)
                        uninstallList+=("${OPTARG}")
                        ;;
                ?)
                        echo "Unknown option"
                        exit 1
                        ;;
        esac
done

# Show usage if called without an option
if ! [ "${installList}" ] && ! [ "${uninstallList}" ]; then
        showUsage
        exit 1
fi

# Install selected files
for item in "${installList[@]}"; do
        install "${item}"
done

# Uninstall selected files
for item in "${uninstallList[@]}"; do
        uninstall "${item}"
done
