echo_section "Update Linux and upgrade installed packages"
# See also: https://help.ubuntu.com/community/AptGet/Howto

echo_subsection "Update the source list"
sudo apt-get update

echo_subsection "Upgrade all packages"
sudo apt-get dist-upgrade -y

echo_subsection "Fix broken packages"
sudo apt-get -f install

echo_subsection "Remove files no longer needed by installed programs"
sudo apt-get autoclean
