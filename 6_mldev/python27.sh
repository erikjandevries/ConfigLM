echo_section "Preparing Python 2.7 for Machine Learning"

echo_subsection "Installing Python developer tools"
sudo apt-get install -y build-essential python-dev python-setuptools
sudo apt-get install -y gfortran libatlas-dev libatlas3-base liblapack-dev libopenblas-base libopenblas-dev
sudo apt-get install -y scrot python-xlib python-gtk2-dev python-tk libpng12-dev libfreetype6-dev
sudo apt-get install -y graphviz libpq-dev

echo_subsection "Installing prerequisites for SSL for pip"
sudo apt-get install -y libffi-dev libssl-dev

echo_subsection "Installing pip"
# Using apt-get to install python-pip gives an old version; using easy_install instead!
sudo easy_install -U pip

echo_subsection "Configuring SSL for pip"
sudo -H pip install --upgrade pyopenssl ndg-httpsclient pyasn1

echo_subsection "Creating configuration file for Theano to use the CPU"
. config_Theano_for cpu

source virtualenv.sh
