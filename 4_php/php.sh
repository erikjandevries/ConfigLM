echo_section "Installing PHP"

# On Linux Mint 17:
ensure_pkg php5 php5-mysql php5-cli php5-curl php5-gd php5-mcrypt libapache2-mod-php5

# On Linux Mint 18:
# ensure_pkg php7.0 php7.0-mysql libapache2-mod-php7.0 php7.0-mbstring php7.0-common php7.0-gd php7.0-mcrypt php-gettext php7.0-curl php7.0-cli

sudo cp phpinfo.php /var/www/html/
