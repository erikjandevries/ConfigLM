# Creating a virtual env for machine Learning
# and building wheels for machine learning packages

echo_subsection "Creating a virtual env for machine Learning"
source venv_functions.sh

ensure_dir ~/.bash_functions
cp venv_functions.sh ~/.bash_functions
ensure_conf 'source ~/.bash_functions/venv_functions.sh' ~/.bashrc

if [[ -d $VIRTUALENV_FOLDER/ML ]]; then
  echo_subsection "Deleting the existing VirtualEnv ML"
  venv_delete ML
fi
echo_subsection "Creating a new VirtualEnv ML and installing common Machine Learning libraries"
venv_create ML
venv_ml ML
deactivate
# venv_delete ML
