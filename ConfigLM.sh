#!/bin/bash

# Default parameters
USE_SSH=false
START_ALL=false
EXEC_INIT=true

# Command line arguments
# See: http://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash
for i in "$@"
do
case $i in
  -ssh)
  USE_SSH=true
  shift
  ;;
  -a|--start-all)
  START_ALL=true
  shift
  ;;
  --no-init)
  EXEC_INIT=false
  shift
  ;;
esac
done

# Load some custom functions
source ConfigLM_functions.sh

if [ "$EXEC_INIT" = true ] ; then
  if [[ -e 9_private_config/ConfigLM_init.sh ]]; then
    source 9_private_config/ConfigLM_init.sh
  else
    if [[ -e $CONFIGLM_FOLDER/9_private_config/ConfigLM_init.sh ]]; then
      source $CONFIGLM_FOLDER/9_private_config/ConfigLM_init.sh
    fi
  fi
fi

echo_section "Preparing for installation and configuration"
ensure_dir $REPOS_FOLDER
ensure_dir $REPOS_FOLDER/Clones
ensure_dir $SOFTWARE_FOLDER

echo_section "Making sure Git is installed and cloning the repository"
ensure_pkg git
if [ "$USE_SSH" = true ] ; then
  ensure_git_clone git@github.com:erikjandevries/ConfigLM.git $CONFIGLM_FOLDER
else
  ensure_git_clone https://github.com/erikjandevries/ConfigLM.git $CONFIGLM_FOLDER
fi

if [ "$START_ALL" = true ] ; then
  source $CONFIGLM_FOLDER/start-all.sh
fi

source $CONFIGLM_FOLDER/ConfigLM_cleanup.sh
