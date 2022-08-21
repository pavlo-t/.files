#!/bin/sh

# https://wiki.archlinux.org/title/VirtualBox#Load_the_VirtualBox_kernel_modules
modprobe -r vboxnetadp vboxnetflt
modprobe -r vboxdrv
