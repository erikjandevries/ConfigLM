echo_section "Installing MariaDB"

ensure_pkg mariadb-client

if [ $(dpkg-query -W -f='${Status}' mariadb-server 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  sudo debconf-set-selections <<< "maria-db-$MARIADB_VERSION mysql-server/root_password password $mariadb_root_password"
  sudo debconf-set-selections <<< "maria-db-$MARIADB_VERSION mysql-server/root_password_again password $mariadb_root_password"

  sudo apt-get install -y mariadb-server

  echo_subsection "Installing system db"
  sudo service mysql stop
  sudo mysql_install_db
  sudo service mysql start

  echo_subsection "Securing installation"
  sudo cp mysql_secure_installation_automated_5.5 /usr/bin/mysql_secure_installation_automated
  sudo chmod 755 /usr/bin/mysql_secure_installation_automated
  sudo mysql_secure_installation_automated $mariadb_root_password
else
  echo "mariadb-server is already installed";
fi
