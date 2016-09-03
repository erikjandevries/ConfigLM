echo_section "Creating a temporary VirtualEnv and testing matplotlib"

if [[ -d $VIRTUALENV_FOLDER/ML ]]; then
  echo_subsection "VirtualEnv ML found... activating for testing"
  venv_activate ML
else
  VENV_NAME=matplotlib

  echo_subsection "Creating and activating a temporary VirtualEnv"
  venv_create $VENV_NAME

  echo_subsection "Creating symbolic links for using PyGTK (with matplotlib) in the virtualenv"
  ln -sf /usr/lib/python2.7/dist-packages/{glib,gobject,cairo,gtk-2.0,pygtk.py,pygtk.pth} $VIRTUALENV_FOLDER/$VENV_NAME/lib/python2.7/site-packages

  echo_subsection "Configuring SSL for pip in the VirtualEnv\033[0m"
  pip install pyopenssl ndg-httpsclient pyasn1

  echo_subsection "Installing \033[1;32mnumpy\033[1;33m in the VirtualEnv\033[0m"
  pip install numpy
  echo_subsection "Installing \033[1;32mmatplotlib\033[1;33m in the VirtualEnv\033[0m"
  pip install matplotlib
fi

echo_subsection "\033[44m Running a test-script with Python    \n You should see a graph window appear "
python matplotlib_graph.py

if [[ ! -d $VIRTUALENV_FOLDER/ML ]]; then
  echo_subsection "Deactivating and removing the VirtualEnv"
  deactivate
  venv_delete $VENV_NAME
fi

echo -e ""
echo_section "Finished creating a temporary VirtualEnv and testing matplotlib"
echo -e ""
