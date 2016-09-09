echo_section "Installing R and RStudio Server"

echo_subsection "Installing R"
ensure_pkg r-base r-base-dev
# To install the devtools package
ensure_pkg libcurl4-gnutls-dev libxml2-dev libssl-dev


echo_subsection "Downloading RStudio server"
ensure_dir $SOFTWARE_FOLDER/RStudio
if [[ ! -e $SOFTWARE_FOLDER/RStudio/rstudio-server-0.99.903-amd64.deb ]]; then
  wget -O $SOFTWARE_FOLDER/RStudio/rstudio-server-0.99.903-amd64.deb https://download2.rstudio.org/rstudio-server-0.99.903-amd64.deb
else
  echo "RStudio Server package has already been downloaded"
fi

echo_subsection "Installing RStudio server"
if [ $(dpkg-query -W -f='${Status}' rstudio-server 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  ensure_pkg gdebi-core
  sudo gdebi $SOFTWARE_FOLDER/RStudio/rstudio-server-0.99.903-amd64.deb
else
  echo "rstudio-server is already installed";
fi
