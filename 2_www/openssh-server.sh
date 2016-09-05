echo_section "Installing OpenSSH Server"

echo_subsection "Installing latest security stack"
sudo apt-get install -y xserver-xorg-lts-xenial libwayland-egl1-mesa-lts-xenial libgl1-mesa-glx-lts-xenial:i386 libgl1-mesa-glx-lts-xenial

echo_subsection "Installing OpenSSH Server"
sudo apt-get install -y openssh-server

echo_section "Configuring OpenSSH Server for authentication with keys only"
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.defaults
sudo sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config
sudo service ssh restart
