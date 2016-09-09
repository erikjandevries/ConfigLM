echo_section "Installing R and RStudio Server"

ensure_pkg gdebi-core

echo_subsection "Installing R"
# ensure_conf 'deb http://cran.rstudio.com/bin/linux/ubuntu precise/' /etc/apt/sources.list -sudo
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
sudo add-apt-repository -y ppa:marutter/rdev
sudo apt-get update
ensure_pkg r-base r-base-dev

# To install the devtools package
ensure_pkg libcurl4-gnutls-dev libxml2-dev libssl-dev

echo_subsection "Installing R packages"
sudo su - -c "R -e \"install.packages('devtools', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('rmarkdown', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('shiny', repos='https://cran.rstudio.com/')\""

echo_subsection "Downloading RStudio Server"
ensure_dir $SOFTWARE_FOLDER/RStudio
if [[ ! -e $SOFTWARE_FOLDER/RStudio/rstudio-server-0.99.903-amd64.deb ]]; then
  wget -O $SOFTWARE_FOLDER/RStudio/rstudio-server-0.99.903-amd64.deb https://download2.rstudio.org/rstudio-server-0.99.903-amd64.deb
else
  echo "RStudio Server package has already been downloaded"
fi

echo_subsection "Installing RStudio Server"
if [ $(dpkg-query -W -f='${Status}' rstudio-server 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  sudo gdebi $SOFTWARE_FOLDER/RStudio/rstudio-server-0.99.903-amd64.deb
else
  echo "rstudio-server is already installed";
fi

echo_subsection "Downloading Shiny Server"
ensure_dir $SOFTWARE_FOLDER/RStudio
if [[ ! -e $SOFTWARE_FOLDER/RStudio/shiny-server-1.4.4.801-amd64.deb ]]; then
  wget -O $SOFTWARE_FOLDER/RStudio/shiny-server-1.4.4.801-amd64.deb https://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.4.4.801-amd64.deb
else
  echo "Shiny Server package has already been downloaded"
fi

echo_subsection "Installing Shiny Server"
if [ $(dpkg-query -W -f='${Status}' shiny-server 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  sudo gdebi $SOFTWARE_FOLDER/RStudio/shiny-server-1.4.4.801-amd64.deb
else
  echo "shiny-server is already installed";
fi

echo_subsection "Restarting Nginx"
sudo service nginx restart
