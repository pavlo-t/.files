#!/bin/sh

# https://wiki.archlinux.org/title/VirtualBox#Load_the_VirtualBox_kernel_modules
modprobe vboxdrv
## Required to use `bridged` and `host-only` networks
# modprobe -a vboxdrv vboxnetadp vboxnetflt
