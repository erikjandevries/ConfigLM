echo_section "Installing Apache www-server"
# https://www.digitalocean.com/community/tutorials/how-to-configure-nginx-as-a-reverse-proxy-for-apache
if [ $(dpkg-query -W -f='${Status}' apache2 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
  ensure_pkg apache2 apache2-doc
  ensure_pkg apache2-mpm-prefork apache2-utils libexpat1
  sudo service apache2 restart
else
  echo_info "Apache www-server has already been installed"
fi
