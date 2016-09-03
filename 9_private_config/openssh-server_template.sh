echo_subsection "Private OpenSSH Server configuration"

# Changing the default port: Good or bad?
# https://danielmiessler.com/blog/putting-ssh-another-port-good-idea/
# https://major.io/2013/05/14/changing-your-ssh-servers-port-from-the-default-is-it-worth-it/

SSH_PORT=22

sudo grep -q -F "Port $SSH_PORT" /etc/ssh/sshd_config || sudo sed -i "s/Port 22/Port $SSH_PORT/" /etc/ssh/sshd_config
sudo service ssh restart
