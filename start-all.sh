# Load some custom functions
if [ "x$CONFIGLM_FOLDER" == "x" ]; then
  source ConfigLM_functions.sh
else
  source $CONFIGLM_FOLDER/ConfigLM_functions.sh
fi

echo_section "Adding ConfigLM common functions to .bashrc"
ensure_dir ~/.bash_functions
cp $CONFIGLM_FOLDER/ConfigLM_functions.sh ~/.bash_functions
ensure_conf 'source ~/.bash_functions/ConfigLM_functions.sh' ~/.bashrc


ensure_dir 9_private_config

ConfigLM_start () {
  if [[ -d $CONFIGLM_FOLDER/$1 ]]; then
    if [[ -e $CONFIGLM_FOLDER/$1/$2 ]]; then
      source $CONFIGLM_FOLDER/$1/$2
    fi
    if [[ -e $CONFIGLM_FOLDER/9_private_config/$2 ]]; then
      source $CONFIGLM_FOLDER/9_private_config/$2
    fi
  fi
}

ConfigLM_start 0_settings load_settings.sh
ConfigLM_start 1_linux update.sh

# Always start with installing CUDA and cuDNN !!
ConfigLM_start 1_linux cuda.sh
ConfigLM_start 1_linux fonts.sh

# Exclude the following lines for Linux Mint 18
ConfigLM_start 1_linux exFAT.sh
ConfigLM_start 1_linux driver_WLAN.sh

ConfigLM_start 2_www nginx.sh
ConfigLM_start 2_www apache.sh
ConfigLM_start 2_www openssh-server.sh

ConfigLM_start 3_db mariadb.sh
ConfigLM_start 3_db postgresql.sh

ConfigLM_start 4_php php.sh
# ConfigLM_start 4_php phpadmin.sh

ConfigLM_start 5_vmhost qemu.sh
ConfigLM_start 5_vmhost xvfb.sh

ConfigLM_start 6_mldev atom.sh
ConfigLM_start 6_mldev rstudio.sh
ConfigLM_start 6_mldev mxnet.sh
ConfigLM_start 6_mldev mxnet-r.sh
ConfigLM_start 6_mldev python27.sh

if [[ -e $CONFIGLM_FOLDER/9_private_config/private.sh ]]; then
  source $CONFIGLM_FOLDER/9_private_config/private.sh
fi
