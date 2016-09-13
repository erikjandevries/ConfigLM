# https://www.digitalocean.com/community/tutorials/how-to-configure-nginx-as-a-reverse-proxy-for-apache
echo_section "Installing Apache www-server"
ensure_pkg apache2 apache2-doc apache2-mpm-prefork apache2-utils libexpat1
sudo service apache2 restart
