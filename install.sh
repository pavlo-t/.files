#!/bin/bash

####################################################################################################
echo "=== Install ${HOME} ==="

home=(
	".vim"
	".vimrc"
	".ideavimrc"

	".profile"
	".bashrc"
	".bash_logout"
	#".ascii"
	".config/procps"

	".gitconfig"
	".xinitrc"
	"notes.sh"
)

for file in ${home[@]}; do
	echo "${HOME}/$file"
	rm -rf ${HOME}/${file}
	ln -s ${PWD}/home/${file} ${HOME}/${file}
done

####################################################################################################
echo "=== Install /root ==="

root=(
	".vim"
	".vimrc"

	".profile"
	".bashrc"
	".bash_logout"

	".config/procps"
)

for file in ${root[@]}; do
	echo "/root/$file"
	sudo rm -rf /root/${file}
	sudo ln -s ${PWD}/home/${file} /root/${file}
done

####################################################################################################
SERVICE=startup_scripts
echo "=== Install ${SERVICE}.service ==="
echo "[Unit]
Description=My startup scripts

[Service]
ExecStart=${PWD}/${SERVICE}.sh

[Install]
WantedBy=multi-user.target" > /tmp/${SERVICE}.service

sudo mv /tmp/${SERVICE}.service /etc/systemd/system
sudo systemctl enable ${SERVICE}.service

