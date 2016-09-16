echo_section "Installing the basemap extension to the matplotlib library"

ensure_dir $SOFTWARE_FOLDER/Basemap

if [[ ! -d "$SOFTWARE_FOLDER/Basemap/basemap-1.0.7" ]]; then
  if [[ ! -e "$SOFTWARE_FOLDER/Basemap/basemap-1.0.7.tar.gz" ]]; then
    echo_subsection "Downloading basemap package archive"
    wget -O $SOFTWARE_FOLDER/Basemap/basemap-1.0.7.tar.gz http://sourceforge.net/projects/matplotlib/files/matplotlib-toolkits/basemap-1.0.7/basemap-1.0.7.tar.gz
  else
    echo_info "Basemap package archive has already been downloaded"
  fi

  echo_subsection "Extracting basemap package archive"
  tar -xzf $SOFTWARE_FOLDER/Basemap/basemap-1.0.7.tar.gz -C $SOFTWARE_FOLDER/Basemap/

  # rm $SOFTWARE_FOLDER/Basemap/basemap-1.0.7.tar.gz
else
  echo_info "Basemap package archive has already been extracted"
fi

export GEOS_DIR=/usr/local/GEOS
if [[ ! -d "$GEOS_DIR/bin" ]]; then
  echo_subsection "Compiling GEOS library"
  cd $SOFTWARE_FOLDER/Basemap/basemap-1.0.7/geos-3.3.3
  sudo ./configure --prefix=$GEOS_DIR
  sudo make
  sudo make install
else
  echo_info "GEOS library found at $GEOS_DIR"
fi

# cd $SOFTWARE_FOLDER/Basemap/basemap-1.0.7
# python setup.py install
pip install --upgrade $SOFTWARE_FOLDER/Basemap/basemap-1.0.7

cd $CONFIGLM_FOLDER
