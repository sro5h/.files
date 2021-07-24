#! /bin/bash

if [ -f ~/.Xresources ]; then
        xrdb -merge -I$HOME ~/.Xresources
fi

exec bspwm
