echo_section "Installing MXNet R Package"
# sudo rm -rf $REPOS_FOLDER/Clones/mxnet/mxnet_0.7.tar.gz
if [[ ! -e $REPOS_FOLDER/Clones/mxnet/mxnet_0.7.tar.gz ]]; then
  echo_info "Compiling MXNet R Package"
  cd $REPOS_FOLDER/Clones/mxnet/R-package
  Rscript -e "library(devtools); library(methods); options(repos=c(CRAN='https://cran.rstudio.com')); install_deps(dependencies = TRUE)"
  cd ..
  make rpkg
else
  echo_warn "MXNet R Package has already been compiled"
fi
# sudo R CMD INSTALL $REPOS_FOLDER/Clones/mxnet/mxnet_0.7.tar.gz
echo_info "Installing MXNet R Package in site-library"
sudo su - -c "R CMD INSTALL $REPOS_FOLDER/Clones/mxnet/mxnet_0.7.tar.gz"

cd $CONFIGLM_FOLDER
