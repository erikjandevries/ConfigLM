echo_section "Installing Microsoft core fonts"
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
ensure_pkg ttf-mscorefonts-installer
