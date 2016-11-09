echo_section "Installing driver for WLAN USB"

replace_conf 'blacklist bcm43xx' '#blacklist bcm43xx' /etc/modprobe.d/blacklist.conf -sudo
ensure_pkg linux-firmware-nonfree
sudo modprobe b43
