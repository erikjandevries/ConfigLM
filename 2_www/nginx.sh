# https://www.digitalocean.com/community/tutorials/how-to-configure-nginx-as-a-reverse-proxy-for-apache
# https://www.digitalocean.com/community/tutorials/how-to-configure-nginx-as-a-web-server-and-reverse-proxy-for-apache-on-one-ubuntu-14-04-droplet
# https://support.rstudio.com/hc/en-us/articles/200552326-Running-RStudio-Server-with-a-Proxy
# https://support.rstudio.com/hc/en-us/articles/213733868-Running-Shiny-Server-with-a-Proxy
echo_section "Installing Nginx www-server and proxy"
ensure_pkg nginx

sudo cp $CONFIGLM_FOLDER/2_www/nginx-default-site /etc/nginx/sites-available/default-ConfigLM
sudo rm /etc/nginx/sites-enabled/default
ensure_sl /etc/nginx/sites-available/default-ConfigLM /etc/nginx/sites-enabled/default

ensure_dir /etc/nginx/ssl -sudo
if [[ ! -e /etc/nginx/ssl/nginx.key ]]; then
  sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -subj "/CN=localhost" \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt
fi

sudo service nginx restart
