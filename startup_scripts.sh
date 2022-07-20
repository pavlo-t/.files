#!/bin/sh

mkdir -p /tmp/downloads/.qBittorrent
chown -R 1000:1000 /tmp/downloads
echo "[Desktop Entry]
Icon=folder-downloads" > /tmp/downloads/.directory
