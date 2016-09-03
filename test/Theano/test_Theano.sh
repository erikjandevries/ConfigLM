echo_subsection "Creating a temporary VirtualEnv and testing Theano"
if [[ -d $VIRTUALENV_FOLDER/ML ]]; then
  echo_subsection "VirtualEnv ML found... activating for testing"
  venv_activate ML
else
  VENV_NAME=matplotlib

  echo_subsection "Creating and activating a temporary VirtualEnv"
  venv_create $VENV_NAME

  echo_subsection "Configuring SSL for pip in the VirtualEnv\033[0m"
  pip install pyopenssl ndg-httpsclient pyasn1

  echo_subsection "Installing \033[1;32mnumpy\033[1;33m in the VirtualEnv"
  pip install numpy

  echo_subsection "Installing \033[1;32mnose\033[1;33m in the VirtualEnv"
  pip install nose

  echo_subsection "Installing \033[1;32mTheano\033[1;33m in the VirtualEnv"
  pip install Theano
fi

echo_subsection "\033[44m Running a test-script with Python and Theano"
python Theano_test.py

if [[ -d $VIRTUALENV_FOLDER/ML ]]; then
  echo_subsection "Deactivating the VirtualEnv"
  deactivate
else
  echo_subsection "Deactivating and removing the VirtualEnv"
  deactivate
  venv_delete $VENV_NAME
fi

echo -e ""
echo_section "Finished creating a temporary VirtualEnv and testing Theano"
echo -e ""
