echo_section "Installing nVidia CUDA"

CUDA_DEB_PACKAGE=$SOFTWARE_FOLDER/CUDA/cuda-repo-ubuntu1404-7-5-local_7.5-18_amd64.deb

if [[ -e $CUDA_DEB_PACKAGE ]]; then
  echo_subsection "Installing nVidia CUDA .deb package"
  sudo dpkg -i $CUDA_DEB_PACKAGE
  sudo apt-get update

  echo_subsection "Installing nVidia drivers 352.39 from .deb package"
  sudo apt-get install -y nvidia-352=352.39-0ubuntu1 nvidia-settings=352.39-0ubuntu1

  sudo nvidia-xconfig

  echo_subsection "Installing nVidia CUDA"
  sudo apt-get install -y cuda

  ensure_conf "export CUDA_ROOT=/usr/local/cuda-7.5" ~/.bashrc
  ensure_conf "export PATH=\${CUDA_ROOT}/bin:\${PATH}" ~/.bashrc
  ensure_conf "export LD_LIBRARY_PATH=\${CUDA_ROOT}/lib64:\${LD_LIBRARY_PATH}" ~/.bashrc

  export CUDA_ROOT=/usr/local/cuda-7.5
  export PATH=${CUDA_ROOT}/bin:${PATH}
  export LD_LIBRARY_PATH=${CUDA_ROOT}/lib64:${LD_LIBRARY_PATH}

  CUDNN_FOLDER=$SOFTWARE_FOLDER/cuDNN/cudnn-7.5-linux-x64-v5.0-ga
  if [[ -d $CUDNN_FOLDER ]]; then
    sudo cp $CUDNN_FOLDER/include/* ${CUDA_ROOT}/include
    sudo cp $CUDNN_FOLDER/lib64/* ${CUDA_ROOT}/lib64
  else
    echo_warning "cuDNN files not found ($CUDNN_FOLDER)"
  fi
else
  echo_warning "CUDA package not found ($CUDA_DEB_PACKAGE)"
fi
