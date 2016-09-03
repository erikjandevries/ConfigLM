echo_section "Creating a temporary VirtualEnv and testing Jupyter"

VENV_NAME=Jupyter

echo_subsection "Creating and activating a temporary VirtualEnv"
venv_create $VENV_NAME

echo_subsection "Configuring SSL for pip in the VirtualEnv"
pip install pyopenssl ndg-httpsclient pyasn1

echo_subsection "Installing \033[1;32mJupyter\033[1;33m in the VirtualEnv"
pip install --upgrade jupyter

echo_subsection "\033[44m Running a test-notebook with Python \n You should see a Jupyter notebook appear "
jupyter notebook jupyter_python_test.ipynb

echo_subsection "Deactivating and removing the VirtualEnv"
deactivate
venv_delete $VENV_NAME

echo -e ""
echo_section "Finished creating a temporary VirtualEnv and testing Jupyter"
echo -e ""
