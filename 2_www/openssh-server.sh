echo_section "Installing OpenSSH Server"

# echo_subsection "Installing latest security stack"
# sudo apt-get install -y xserver-xorg-lts-xenial libwayland-egl1-mesa-lts-xenial libgl1-mesa-glx-lts-xenial:i386 libgl1-mesa-glx-lts-xenial

echo_subsection "Installing OpenSSH Server"
ensure_pkg openssh-server

echo_section "Configuring OpenSSH Server for authentication with keys only"
if [[ ! -e /etc/ssh/sshd_config.defaults ]]; then
  echo "Creating backup copy of the configuration file"
  sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.defaults
else
  echo "Backup copy of default configuration file already exists"
fi
echo
replace_conf "PasswordAuthentication yes" "PasswordAuthentication no" /etc/ssh/sshd_config -sudo
replace_conf "#PasswordAuthentication yes" "PasswordAuthentication no" /etc/ssh/sshd_config -sudo
sudo service ssh restart
