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
        echo "  -i <dir>        Install <dir>"
        echo "  -u <dir>        Uninstall <dir>"
        echo "  -U              Uninstall all"
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
while getopts "hi:u:U" opt; do
        case ${opt} in
                h)
                        showUsage
                        exit 0
                        ;;
                i)
                        installList+=("${OPTARG}")
                        ;;
                u)
                        uninstallList+=("${OPTARG}")
                        ;;
                U)
                        uninstallList=(*/)
                        ;;
                ?)
                        echo "Unknown option"
                        exit 1
                        ;;
        esac
done

# Install all if no option is passed
if ! [ "${installList}" ] && ! [ "${uninstallList}" ]; then
        installList=(*/)
fi

# Install selected files
for item in "${installList[@]}"; do
        install "${item}"
done

# Uninstall selected files
for item in "${uninstallList[@]}"; do
        uninstall "${item}"
done

echo "Done."
