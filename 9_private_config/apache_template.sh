echo_subsection "Private Apache configuration"

MYFQDN="my.domain.com"

sudo grep -q -F "$MYFQDN" /etc/hosts || sudo sed -i "s/127.0.0.1\tlocalhost/127.0.0.1\tlocalhost $MYFQDN/" /etc/hosts
# sudo sed -i "s/::1     ip6-localhost ip6-loopback/::1     ip6-localhost ip6-loopback $MYFQDN/" /etc/hosts

ensure_conf "ServerName $MYFQDN" /etc/apache2/apache2.conf -sudo

sudo service apache2 restart
