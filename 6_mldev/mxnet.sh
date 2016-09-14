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

echo_subsection "Compiling MXNet library"
cd $REPOS_FOLDER/Clones/mxnet; make -j$(nproc)

echo_subsection "Installing Python Package"
pip install --upgrade -e $REPOS_FOLDER/Clones/mxnet/python/

echo_subsection "Installing R Package"
if [[ ! -e $REPOS_FOLDER/Clones/mxnet/mxnet_0.7.tar.gz ]]; then
  cd $REPOS_FOLDER/Clones/mxnet/R-package
  sudo Rscript -e "library(devtools); library(methods); options(repos=c(CRAN='https://cran.rstudio.com')); install_deps(dependencies = TRUE)"
  cd ..
  make rpkg
fi

sudo R CMD INSTALL mxnet_0.7.tar.gz
