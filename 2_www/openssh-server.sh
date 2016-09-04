echo_section "Installing OpenSSH Server"

sudo apt-get install -y openssh-server

sudo sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config
sudo service ssh restart
