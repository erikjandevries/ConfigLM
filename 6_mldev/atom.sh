echo_section "Installing the Atom text editor"

ensure_dir $SOFTWARE_FOLDER/Atom
if [[ ! -e $SOFTWARE_FOLDER/Atom/atom-amd64.deb ]]; then
  wget -O $SOFTWARE_FOLDER/Atom/atom-amd64.deb https://atom.io/download/deb
else
  echo "Atom package has already been downloaded"
fi

if [ $(dpkg-query -W -f='${Status}' atom 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  sudo dpkg -i $SOFTWARE_FOLDER/Atom/atom-amd64.deb

  apm install atom-alignment
  apm install atomatigit
  apm install language-lua
  apm install language-matlab
  apm install language-r
  apm install merge-conflicts
  apm install split-diff

  apm upgrade --no-confirm
else
  echo "atom is already installed"
fi
