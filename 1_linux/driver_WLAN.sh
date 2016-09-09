echo_section "Installing driver for WLAN USB"
ensure_pkg linux-firmware-nonfree
sudo modprobe b43
