echo_section "Installing MXNet"

ensure_pkg build-essential git libatlas-base-dev libopencv-dev
if [[ ! -e $REPOS_FOLDER/Clones/mxnet ]]; then
  echo -e "Cloning git repository https://github.com/dmlc/mxnet"
  git clone --recursive https://github.com/dmlc/mxnet $REPOS_FOLDER/Clones/mxnet
else
  echo -e "Git repository exists at"
  echo -e "${font_dim}$REPOS_FOLDER/Clones/mxnet${font_default}"
  echo -e "Pulling latest version ${font_dim}(but ${color_orange}origin has not been checked${color_default})${font_default}"
  git -C $REPOS_FOLDER/Clones/mxnet pull
fi

cp $REPOS_FOLDER/Clones/mxnet/make/config.mk $REPOS_FOLDER/Clones/mxnet/config.mk

if [ "x$CUDA_ROOT" == "x" ]; then
  echo_info "CUDA not found, compiling without CUDA support"
else
  echo_info "CUDA found, compiling with CUDA support"
  replace_conf "USE_CUDA = 0" "USE_CUDA = 1" $REPOS_FOLDER/Clones/mxnet/config.mk -sudo
  if [[ -e $CUDA_ROOT/lib64/libcudnn.so ]]; then
    echo_info "cuDNN found, compiling with cuDNN support"
    replace_conf "USE_CUDNN = 0" "USE_CUDNN = 1" $REPOS_FOLDER/Clones/mxnet/config.mk -sudo
  else
    echo_info "cuDNN not found, compiling without cuDNN support"
  fi
  echo_info "Compiling with NVRTC CUDA Runtime Compiling support"
  replace_conf "USE_NVRTC = 0" "USE_NVRTC = 1" $REPOS_FOLDER/Clones/mxnet/config.mk -sudo
fi

# sudo rm -rf $REPOS_FOLDER/Clones/mxnet/lib/
if [[ ! -e $REPOS_FOLDER/Clones/mxnet/lib/libmxnet.so ]]; then
  echo_subsection "Compiling MXNet library"
  cd $REPOS_FOLDER/Clones/mxnet; make -j$(nproc)
else
  echo_warn "MXNet library has already been compiled"
fi

echo_subsection "Installing Python Package"
pip install --upgrade -e $REPOS_FOLDER/Clones/mxnet/python/

echo_subsection "Installing R Package"
# sudo rm -rf $REPOS_FOLDER/Clones/mxnet/mxnet_0.7.tar.gz
if [[ ! -e $REPOS_FOLDER/Clones/mxnet/mxnet_0.7.tar.gz ]]; then
  echo_info "Compiling R Package"
  cd $REPOS_FOLDER/Clones/mxnet/R-package
  sudo Rscript -e "library(devtools); library(methods); options(repos=c(CRAN='https://cran.rstudio.com')); install_deps(dependencies = TRUE)"
  cd ..
  make rpkg
else
  echo_warn "R Package has already been compiled"
fi
sudo R CMD INSTALL $REPOS_FOLDER/Clones/mxnet/mxnet_0.7.tar.gz
