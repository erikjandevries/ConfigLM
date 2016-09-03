echo_section "Installing driver for WLAN USB"

sudo apt-get install -y linux-firmware-nonfree
sudo modprobe b43
