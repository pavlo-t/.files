#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

## Set fcitx as default input module
#export GTK_IM_MODULE=fcitx
#export QT_IM_MODULE=fcitx
#export XMODIFIERS=@im=fcitx

export DESKTOP_SESSION=plasma

# Gnome keyring
#eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
#export SSH_AUTH_SOCK

# Here KDE is kept as default to start with `$ startx`
session=${1:-kde}

# Here you can set shortcuts to run any command with `$ startx ./xinitrc [shortcut|command]`
case $session in
    # fluxbox           ) exec startfluxbox;;
    # kde               ) exec startkde;;
    kde               ) exec startplasma-x11;;
    # openbox           ) exec openbox-session;;
    # No known session, try to run it as command
    *                 ) exec $1;;
esac


