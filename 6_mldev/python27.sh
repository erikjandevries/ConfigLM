echo_section "Preparing Python 2.7 for Machine Learning"

echo_subsection "Installing Python developer tools"
ensure_pkg build-essential python-dev python-setuptools
ensure_pkg gfortran libatlas-dev libatlas3-base liblapack-dev libopenblas-base libopenblas-dev
ensure_pkg scrot python-xlib python-gtk2-dev python-tk libpng12-dev libfreetype6-dev
ensure_pkg graphviz libpq-dev

echo_subsection "Installing prerequisites for SSL for pip"
ensure_pkg libffi-dev libssl-dev

echo_subsection "Installing pip"
# Using apt-get to install python-pip gives an old version; using easy_install instead!
sudo easy_install -U pip

echo_subsection "Configuring SSL for pip"
sudo -H pip install --upgrade pyopenssl ndg-httpsclient pyasn1

echo_subsection "Creating configuration file for Theano to use the CPU"
. config_Theano_for cpu

source virtualenv.sh
