echo_subsection "Private Nginx configuration"

MYFQDN="my.domain.com"

replace_conf "  server_name your_domain.com;" "  server_name $MYFQDN;" /etc/nginx/sites-available/default-ConfigLM -sudo

ensure_dir /etc/nginx/ssl -sudo
if [[ ! -e /etc/nginx/ssl/nginx.key ]]; then
  if [[ ! -e ~/.ssh/nginx.key ]]; then
    sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
      -subj "/O=My Organisation/OU=My Unit/CN=$MYFQDN" \
      -keyout /etc/nginx/ssl/nginx.key \
      -out /etc/nginx/ssl/nginx.crt
  fi
  cp ~/.ssh/nginx.key /etc/nginx/ssl/nginx.key
  cp ~/.ssh/nginx.crt /etc/nginx/ssl/nginx.crt
fi

# ensure_dir /usr/share/ca-certificates/ConfigLM -sudo
# sudo cp ~/.ssh/$MYFQDN.crt /usr/share/ca-certificates/ConfigLM/
# sudo dpkg-reconfigure ca-certificates

sudo service nginx restart
