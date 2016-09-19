echo_section "Installing nVidia CUDA 7.5 and cuDNN 5.0"

if [ $(dpkg-query -W -f='${Status}' cuda 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
  CUDA_DEB_PACKAGE=$SOFTWARE_FOLDER/CUDA/cuda-repo-ubuntu1404-7-5-local_7.5-18_amd64.deb

  if [[ -e $CUDA_DEB_PACKAGE ]]; then
    echo_subsection "Installing nVidia CUDA .deb package"
    sudo dpkg -i $CUDA_DEB_PACKAGE
    sudo apt-get update

    echo_subsection "Installing nVidia drivers 352.39 from .deb package"
    ensure_pkg nvidia-352=352.39-0ubuntu1 nvidia-settings=352.39-0ubuntu1

    sudo nvidia-xconfig

    echo_subsection "Installing nVidia CUDA"
    ensure_pkg cuda

    ensure_conf "export CUDA_ROOT=/usr/local/cuda-7.5" ~/.bashrc
    ensure_conf "export PATH=\${CUDA_ROOT}/bin:\${PATH}" ~/.bashrc
    ensure_conf "export LD_LIBRARY_PATH=\${CUDA_ROOT}/lib64:\${LD_LIBRARY_PATH}" ~/.bashrc

    sudo touch /root/.bashrc
    ensure_conf "export CUDA_ROOT=/usr/local/cuda-7.5" /root/.bashrc -sudo
    ensure_conf "export PATH=\${CUDA_ROOT}/bin:\${PATH}" /root/.bashrc -sudo
    ensure_conf "export LD_LIBRARY_PATH=\${CUDA_ROOT}/lib64:\${LD_LIBRARY_PATH}" /root/.bashrc -sudo

    # To enable CUDA support for MXNet in RStudio Server
    sudo touch /usr/lib/R/etc/ldpaths
    ensure_conf "export CUDA_ROOT=/usr/local/cuda-7.5" /usr/lib/R/etc/ldpaths -sudo
    ensure_conf "export LD_LIBRARY_PATH=\${CUDA_ROOT}/lib64:\${LD_LIBRARY_PATH}" /usr/lib/R/etc/ldpaths -sudo

    source ~/.bashrc

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
else
  echo_info "CUDA has already been installed"
fi
