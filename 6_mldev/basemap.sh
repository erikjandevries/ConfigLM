echo_section "Installing the basemap extension to the matplotlib library"

ensure_dir $SOFTWARE_FOLDER/Basemap
if [[ ! -e "$SOFTWARE_FOLDER/Basemap/basemap-1.0.7.tar.gz" ]]; then
  wget -O $SOFTWARE_FOLDER/Basemap/basemap-1.0.7.tar.gz http://sourceforge.net/projects/matplotlib/files/matplotlib-toolkits/basemap-1.0.7/basemap-1.0.7.tar.gz
fi

tar -xzf $SOFTWARE_FOLDER/Basemap/basemap-1.0.7.tar.gz

export GEOS_DIR=~/GEOS/
cd basemap-1.0.7/geos-3.3.3
./configure --prefix=$GEOS_DIR
make
make install
cd ..
python setup.py install
cd ..
rm -rf basemap-1.0.7
