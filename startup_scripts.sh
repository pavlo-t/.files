#!/bin/sh

mkdir -p /tmp/downloads/.qBittorrent
echo "[Desktop Entry]
Icon=folder-downloads" > /tmp/downloads/.directory
chown -R 1000:1000 /tmp/downloads
