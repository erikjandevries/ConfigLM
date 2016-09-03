echo_section "Cleaning up"

if [[ -e ~/ConfigLM.sh ]]; then
  if [[ -e ~/ConfigLM_functions.sh ]]; then
    if [[ -e $CONFIGLM_FOLDER/ConfigLM.sh ]]; then
      if [[ -e $CONFIGLM_FOLDER/ConfigLM_functions.sh ]]; then
        rm ~/ConfigLM.sh
        rm ~/ConfigLM_functions.sh
      fi
    fi
  fi
fi
