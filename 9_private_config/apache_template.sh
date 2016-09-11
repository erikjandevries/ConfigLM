# https://www.digitalocean.com/community/tutorials/how-to-configure-nginx-as-a-reverse-proxy-for-apache
# https://www.digitalocean.com/community/tutorials/how-to-configure-nginx-as-a-web-server-and-reverse-proxy-for-apache-on-one-ubuntu-14-04-droplet

# Django configuration
# http://thecodeship.com/deployment/deploy-django-apache-virtualenv-and-mod_wsgi/

echo_subsection "Private Apache configuration"

MYFQDN="my.domain.com"
WWW_PORT=8080

sudo grep -q -F "$MYFQDN" /etc/hosts || sudo sed -i "s/127.0.0.1\tlocalhost/127.0.0.1\tlocalhost $MYFQDN/" /etc/hosts
# sudo sed -i "s/::1     ip6-localhost ip6-loopback/::1     ip6-localhost ip6-loopback $MYFQDN/" /etc/hosts

ensure_conf "ServerName $MYFQDN" /etc/apache2/apache2.conf -sudo
replace_conf "Listen 80\n" "Listen $WWW_PORT\n" /etc/apache2/ports.conf -sudo

sudo cp apache-default.conf /etc/apache2/sites-available/000-default.conf
replace_conf "<VirtualHost \*:80>" "<VirtualHost \*:$WWW_PORT>" /etc/apache2/sites-available/000-default.conf -sudo
sudo rm /etc/apache2/sites-enabled/000-default.conf
ensure_sl /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-enabled/000-default.conf

sudo service apache2 restart
