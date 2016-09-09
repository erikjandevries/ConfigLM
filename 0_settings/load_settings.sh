echo_section "Loading settings"

if [ $(dpkg-query -W -f='${Status}' mariadb-server 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  echo_subsection "MariaDB"
  MARIADB_VERSION=5.5

  if [ "x$mariadb_root_password" == "x" ]; then
    read -s -p "MariaDB database root password:" mariadb_root_password
    echo
    read -s -p "Please enter again:" mariadb_root_password2
    echo
  fi

  while [ "$mariadb_root_password" != "$mariadb_root_password2" ]; do
    echo "Passwords don't match!"
    echo ""
    read -s -p "MariaDB database root password:" mariadb_root_password
    echo
    read -s -p "Please enter again:" mariadb_root_password2
    echo
  done
fi
