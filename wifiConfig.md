### Add new network:
`wpa_passphrase WifiName WifiPassword >> /etc/wpa_supplicant-wlp14s0.conf`

### Manual start:
1. `rfkill unblock wifi`
2. `wpa_supplicant [-B] -i wlp14s0 -c /etc/wpa_supplicant/wpa_supplicant-wlp14s0.conf`
3. `ifconfig wlp14s0 192.168.0.102 netmask 255.255.255.0 broadcast 192.168.0.255 up`
4. `route add default gw 192.168.0.1`
5. `echo 'nameserver 192.168.0.1' >> /etc/resolv.conf`

### Start with service and dhcp:
1. `rfkill unblock wifi`
2. `systemctl stop wpa_supplicant.service`
3. `systemctl start wpa_supplicant@wlp14s0.service`
4. `dhcpcd`
