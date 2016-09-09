# Configure Linux Mint

This is a collection of scripts that will set up a clean installation of
Linux Mint 17 (18 or a recent installation of Ubuntu should probably also work, but those have not been tested) for the following purposes:

1. Linux Mint (drivers, configuration, etc.)
2. WWW (Webserver and connectivity)
3. Database
4. PHP
5. Virtual machine host
6. Machine Learning and Development tools

and optionally: your own private configuration

## Before you start

These scripts require the following:

* A clean installation of Linux Mint (17/18)

To modify the default configuration, or to add your own private configurations, see below.


## How to use

### Quick start

The quickest way to start, is to open a terminal in your home folder and
execute the following code block:

    wget -qO- https://raw.githubusercontent.com/erikjandevries/ConfigLM/master/ConfigLM.sh > ConfigLM.sh
    wget -qO- https://raw.githubusercontent.com/erikjandevries/ConfigLM/master/ConfigLM_functions.sh > ConfigLM_functions.sh
    . ConfigLM.sh -ssh

This script installs git and clones this repository into a subfolder of
~/Repositories/Clones. (If an existing clone is found, the script will pull the
latest version of the repository.)
If you have not configured your ssh key yet, do not use the `-ssh` argument.

Optional parameters for `ConfigLM.sh`:

Parameter | Explanation
--- | ---
`-ssh` | use SSH (with a pre-configured key) to clone the repository
`--start-all` | start the script `start-all.sh` after cloning the repository

### Modifications

#### Selecting components

You could also at first only clone the repository, and configure the various scripts
to include only the parts you need, before start the entire configuration process. In this case it is recommended to edit the start-all.sh script and to comment out the lines you don't need.

Extra additions can be included in your own scripts in the `9_private_config` folder (see below).

#### ConfigLM_init

To run your own commands before cloning the repository, create a file `~/Repositories/Clones/ConfigLM/9_private_config/ConfigLM_init.sh`. It will be run at the beginning of the `ConfigLM.sh` script, after loading the `ConfigLM_functions.sh` file. You might use it, for example, to configure:

* Git, global user name and email address, SSH settings and keys.
* Symbolic links, to redirect the folders ~/Repositories, ~/Software and ~/VirtualEnvs to other locations.

An example/template file is provided: `9_private_config/ConfigLM_init.sh`

#### Private configurations of existing components

For every component script, the process will check if a private configuration script exists as well. For example, after running `2_www/apache.sh`, the process will execute `9_private_config/apache.sh` if it exists. Several template files are included with suggested private modifications.

#### Additional private configurations

The file `9_private_config/start-all.sh` will be started automatically at the end of the standard scripts, just before the cleanup script (if it exists). Here you can, for example, include scripts to install extra software packages.


## What's included?

### Linux

The scripts will perform the following installation and configuration:

* nVidia drivers, CUDA and cuDNN, if available
* Microsoft core fonts
* exFAT file system support
* WLAN drivers

### WWW

* Apache web-server
* OpenSSH Server

### DB

* MariaDB
* PostgreSQL

### PHP

* PHP

### VM-Host

* Qemu

### Machine Learning and Development

* [Atom](https://atom.io/) (Code editor)
* Python 2.7
  * Build essentials, developer tools, setup tools
  * Pip (incl. SSL for Pip)
  * VirtualEnv
    * `venv_create`: a shell function to create a VirtualEnv in the default folder
    * `venv_activate`: a shell function to activate a VirtualEnv in the default folder
    * `venv_delete`: a shell function to delete a VirtualEnv in the default folder
    * `venv_ml`: a shell function to install Machine Learning tools in a VirtualEnv in the default folder, incl.:
      * numpy
      * pandas
      * scipy
      * nltk
      * scikit-learn
      * matplotlib
      * [Theano](http://deeplearning.net/software/theano/)
      * [Lasagne](https://lasagne.readthedocs.io/en/latest/)
      * [OpenAI Gym](https://gym.openai.com/)
      * Jupyter
