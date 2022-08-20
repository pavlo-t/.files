#!/bin/sh

# https://wiki.archlinux.org/title/mirrors#List_by_speed
cd /etc/pacman.d/
cp mirrorlist mirrorlist.$(date -Iseconds).backup
awk '/^## Ukraine$/{f=1; next}f==0{next}/^$/{exit}{print substr($0, 1);}' mirrorlist.pacnew > mirrorlist.ua
sed -i 's/^#Server/Server/' mirrorlist.ua
rankmirrors -n 7 mirrorlist.ua > mirrorlist
