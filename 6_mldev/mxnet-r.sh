echo_section "Installing MXNet R Package"
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
