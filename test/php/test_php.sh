echo_section "Testing PHP"

echo_subsection "Copying phpinfo.php to www-root folder"
sudo cp phpinfo.php /var/www/html/
echo_subsection "Opening phpinfo.php in Firefox"
echo "The page should show the configuration details for PHP and the webserver"
firefox http://localhost/phpinfo.php
echo_subsection "Removing phpinfo.php from www-root folder"
sudo rm /var/www/html/phpinfo.php
