# Load some custom functions
source ConfigLM_functions.sh

echo_section "Adding ConfigLM common functions to .bashrc"
ensure_dir ~/.bash_functions
cp ConfigLM_functions.sh ~/.bash_functions
ensure_conf 'source ~/.bash_functions/ConfigLM_functions.sh' ~/.bashrc


ensure_dir 9_private_config

ConfigLM_start () {
  if [[ -d $1 ]]; then
    cd $1
    if [[ -e $2 ]]; then
      source $2
    fi
    cd ../9_private_config
    if [[ -e $2 ]]; then
      source $2
    fi
    cd ..
  fi
}

ConfigLM_start 0_settings load_settings.sh
ConfigLM_start 1_linux update.sh

# Always start with installing CUDA and cuDNN !!
# ConfigLM_start 1_linux cuda.sh
ConfigLM_start 1_linux fonts.sh

# Exclude the following lines for Linux Mint 18
ConfigLM_start 1_linux exFAT.sh
ConfigLM_start 1_linux driver_WLAN.sh

ConfigLM_start 2_www apache.sh
ConfigLM_start 2_www nginx.sh
ConfigLM_start 2_www openssh-server.sh

ConfigLM_start 3_db mariadb.sh
ConfigLM_start 3_db postgresql.sh

ConfigLM_start 4_php php.sh
# ConfigLM_start 4_php phpadmin.sh

# ConfigLM_start 5_vmhost qemu.sh
ConfigLM_start 5_vmhost xvfb.sh

ConfigLM_start 6_mldev atom.sh
ConfigLM_start 6_mldev rstudio.sh
ConfigLM_start 6_mldev python27.sh

cd 9_private_config
source start-all.sh
cd ..
