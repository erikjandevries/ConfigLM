VIRTUALENV_FOLDER=~/VirtualEnvs
# ensure_dir $VIRTUALENV_FOLDER

venv_activate () {
  ENV_NAME=${1:-env}
  source $VIRTUALENV_FOLDER/$ENV_NAME/bin/activate
}

venv_create () {
  ENV_NAME=${1:-env}

  echo_subsection "Ensuring the latest version of ${color_green}pip${color_yellow} is installed"
  sudo -H pip install --upgrade pip
  echo_subsection "Ensuring the latest version of ${color_green}virtualenv${color_yellow} is installed"
  sudo -H pip install --upgrade virtualenv

  echo_subsection "Creating and activating a temporary VirtualEnv"
  virtualenv $VIRTUALENV_FOLDER/$ENV_NAME
  venv_activate $ENV_NAME
}

venv_delete () {
  ENV_NAME=${1:-env}
  rm -rf $VIRTUALENV_FOLDER/$ENV_NAME
}

venv_ml () {
  ENV_NAME=${1:-env}

  echo_subsection "Creating symbolic links for using PyGTK (with matplotlib) in the virtualenv"
  ln -sf /usr/lib/python2.7/dist-packages/{glib,gobject,cairo,gtk-2.0,pygtk.py,pygtk.pth} $VIRTUALENV_FOLDER/$ENV_NAME/lib/python2.7/site-packages

  echo_subsection "Creating symbolic links for using Xlib in the virtualenv"
  ln -sf /usr/lib/python2.7/dist-packages/Xlib $VIRTUALENV_FOLDER/$ENV_NAME/lib/python2.7/site-packages

  echo_subsection "Configuring SSL for pip in the VirtualEnv"
  pip install --upgrade pyopenssl ndg-httpsclient pyasn1

  echo_subsection "Installing ${color_green}Pillow${color_yellow} in the VirtualEnv"
  pip install --upgrade Pillow

  echo_subsection "Installing ${color_green}PyAutoGUI${color_yellow} for controling the mouse and keyboard"
  pip install --upgrade pyautogui

  echo_subsection "Installing ${color_green}PyVirtualDisplay${color_yellow} in the VirtualEnv"
  pip install pyvirtualdisplay pyscreenshot

  echo_subsection "Installing ${color_green}gprof2dot${color_yellow} for visualising profiler data"
  pip install --upgrade gprof2dot

  echo_subsection "Installing ${color_green}requests${color_yellow} for downloading files"
  pip install --upgrade requests

  echo_subsection "Installing ${color_green}numpy${color_yellow} in the VirtualEnv"
  pip install --upgrade numpy
  echo_subsection "Installing ${color_green}pandas${color_yellow} in the VirtualEnv"
  pip install --upgrade pandas
  echo_subsection "Installing ${color_green}scipy${color_yellow} in the VirtualEnv"
  pip install --upgrade scipy
  echo_subsection "Installing ${color_green}nltk${color_yellow} in the VirtualEnv"
  pip install --upgrade nltk
  echo_subsection "Installing ${color_green}scikit-learn${color_yellow} in the VirtualEnv"
  pip install --upgrade scikit-learn

  echo_subsection "Installing ${color_green}matplotlib${color_yellow} in the VirtualEnv"
  pip install --upgrade matplotlib --no-binary :all:

  echo_subsection "Installing ${color_green}Theano${color_yellow} in the VirtualEnv"
  ensure_git_clone https://github.com/Theano/Theano.git $REPOS_FOLDER/Clones/Theano
  # pip install --upgrade --no-deps git+git://github.com/Theano/Theano.git
  pip install --upgrade --no-deps $REPOS_FOLDER/Clones/Theano

  echo_subsection "Installing ${color_green}Lasagne${color_yellow} in the VirtualEnv"
  ensure_git_clone https://github.com/Lasagne/Lasagne $REPOS_FOLDER/Clones/Lasagne
  # pip install --upgrade https://github.com/Lasagne/Lasagne/archive/master.zip
  pip install --upgrade $REPOS_FOLDER/Clones/Lasagne

  echo_subsection "Installing ${color_green}OpenAI Gym${color_yellow} in the VirtualEnv"
  ensure_git_clone https://github.com/openai/gym $REPOS_FOLDER/Clones/gym
  pip install --upgrade -e $REPOS_FOLDER/Clones/gym

  echo_subsection "Installing ${color_green}psycopg2${color_yellow} in the VirtualEnv"
  pip install --upgrade psycopg2

  echo_subsection "Installing ${color_green}Jupyter${color_yellow} in the VirtualEnv"
  pip install --upgrade jupyter
  R -e "IRkernel::installspec()"

  echo_subsection "Installing ${color_green}Django${color_yellow} in the VirtualEnv"
  pip install --upgrade django

  source $CONFIGLM_FOLDER/6_mldev/basemap.sh

  echo_subsection "Pip list inside the VirtualEnv"
  pip list
}
