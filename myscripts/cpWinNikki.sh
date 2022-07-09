#!/bin/sh

OUT=/tmp/downloads/nikki.md
MNT=/tmp/downloads/win
WIN_PATH=/Users/bc/Documents/nikki.md
USER=bc

mkdir -p ${MNT}
mount /dev/nvme0n1p3 ${MNT}

cp ${MNT}${WIN_PATH} ${OUT}

umount ${MNT}
rmdir ${MNT}

chown ${USER}:${USER} ${OUT}
chmod 600 ${OUT}

ls --group-directories-first --time-style="+%F %T %z" --color=auto -FlashN ${OUT}
