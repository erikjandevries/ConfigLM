# Font formatting: http://misc.flogisoft.com/bash/tip_colors_and_formatting
# Optional function arguments: http://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash

REPOS_FOLDER=~/Repositories
CONFIGLM_FOLDER=~/Repositories/Clones/ConfigLM
SOFTWARE_FOLDER=~/Software

font_default='\033[0m'

color_default='\033[39m'
color_black='\033[30m'
color_red='\033[31m'
color_green='\033[32m'
color_orange='\033[33m'
color_blue='\033[34m'
color_purple='\033[35m'
color_cyan='\033[36m'
color_light_gray='\033[37m'
color_dark_gray='\033[90m'
color_light_red='\033[91m'
color_light_green='\033[92m'
color_yellow='\033[93m'
color_light_blue='\033[94m'
color_light_purple='\033[95m'
color_light_cyan='\033[96m'
color_white='\033[97m'

bg_default='\033[49m'
bg_black='\033[40m'
bg_red='\033[41m'
bg_green='\033[42m'
bg_orange='\033[43m'
bg_blue='\033[44m'
bg_purple='\033[45m'
bg_cyan='\033[46m'
bg_light_gray='\033[47m'
bg_dark_gray='\033[100m'
bg_light_red='\033[101m'
bg_light_green='\033[102m'
bg_yellow='\033[103m'
bg_light_blue='\033[104m'
bg_light_purple='\033[105m'
bg_light_cyan='\033[106m'
bg_white='\033[107m'

font_bold='\033[1m'
font_dim='\033[2m'
font_underline='\033[4m'
font_blink='\033[5m'
font_inverted='\033[7m'
font_hidden='\033[8m'

font_not_bold='\033[21m'
font_not_dim='\033[22m'
font_not_underline='\033[24m'
font_not_blink='\033[25m'
font_not_inverted='\033[27m'
font_not_hidden='\033[28m'

echo_section () {
  # Requires
  # $1: section header
  tmp="                                                                                                              "
  length=${#1}
  line=${tmp:1:$length}
  echo -e "${color_yellow}${bg_black}${font_bold}  $line  ${font_default}"
  echo -e "${color_yellow}${bg_black}${font_bold}  $1  ${font_default}"
  echo -e "${color_yellow}${bg_black}${font_bold}  $line  ${font_default}"
}

echo_subsection () {
  # Requires
  # $1: subsection header
  echo -e ""
  echo -e "${color_orange}${font_bold}$1${font_default}"
}

echo_warning () {
  # Requires
  # $1: warning message
  echo -e "${color_red}${bg_black}${font_bold}$1${font_default}"
}

echo_warn () {
  echo_warning "$1"
}

echo_info () {
  # Requires
  # $1: warning message
  echo -e "${color_light_blue}$1${font_default}"
}

ensure_dir () {
  # Requires:
  # $1: directory path

  # Optional argument:
  # -sudo

  USE_SUDO=false
  if [ $# -gt 1 ]; then
    if [ "$2" = "-sudo" ]; then
      USE_SUDO=true
    fi
  fi

  if [[ ! -e $1 ]]; then
    echo -e "Creating directory $1"
    if [ $USE_SUDO = true ] ; then
      sudo mkdir $1
    else
      mkdir $1
    fi
  elif [[ ! -d $1 ]]; then
    echo_warning "$1 already exists, but is not a directory"
  else
    if [[ -L $1 ]]; then
      echo -e "$1 already exists ${font_dim}(and is a symbolic link to a directory)${font_default}"
    else
      echo -e "$1 already exists ${font_dim}(and is a directory)${font_default}"
    fi
  fi
}

ensure_sl () {
  # Requires
  # $1: source directory
  # $2: target symbolic link
  if [[ ! -e $2 ]]; then
    if [[ -e $1 ]]; then
      echo -e "Creating a symbolic link $2 linking to $1"
      sudo ln -s $1 $2
    else
      echo_warning "Source $1 does not exist"
    fi
  elif [[ ! -L $2 ]]; then
    echo_warning "$2 already exists, but is not a symbolic link"
  else
    echo -e "$2 already exists ${font_dim}(and is a symbolic link, but ${color_orange}target has not been checked${color_default})${font_default}"
  fi
}

ensure_git_clone () {
  # Requires
  # $1: source to clone
  # $2: target dir in which to create the clone
  if [[ ! -e $2 ]]; then
    echo -e "Cloning git repository $1"
    git clone $1 $2
  else
    echo -e "Git repository exists at"
    echo -e "${font_dim}$2${font_default}"
    echo -e "Pulling latest version ${font_dim}(but ${color_orange}origin has not been checked${color_default})${font_default}"
    git -C $2 pull
  fi
}

ensure_conf () {
  # Requires
  # $1: configuration line
  # $2: configuration file

  # Optional third argument:
  # -sudo

  USE_SUDO=false
  if [ $# -gt 2 ]; then
    if [ "$3" = "-sudo" ]; then
      USE_SUDO=true
    fi
  fi

  if [ $USE_SUDO = true ]; then
    sudo touch $2
    sudo grep -q -F "$1" $2 || echo "$1" | sudo tee -a $2
  else
    touch $2
    grep -q -F "$1" $2 || echo "$1" | tee -a $2
  fi
}

replace_conf () {
  # Requires
  # $1: existing configuration line
  # $2: replacement configuration line
  # $3: configuration file

  # Optional fourth argument:
  # -sudo

  USE_SUDO=false
  if [ $# -gt 3 ]; then
    if [ "$4" = "-sudo" ]; then
      USE_SUDO=true
    fi
  fi

  if [ $USE_SUDO = true ]; then
    sudo sed -i "s/$1/$2/" $3
  else
    sed -i "s/$1/$2/" $3
  fi
}

ensure_pkg () {
  # Requires
  # $@: packages to install

  pkgmissing=

  for i in "$@"
  do
    if [ $(dpkg-query -W -f='${Status}' $i 2>/dev/null | grep -c "ok installed") -eq 0 ];
    then
      if [ "x$pkgmissing" != "x" ]; then
        pkgmissing="$pkgmissing $i"
      else
        pkgmissing="$i"
      fi
    else
      echo_info "$i is already installed"
    fi
  done

  if [ "x$pkgmissing" != "x" ]; then
    echo_info "Installing $pkgmissing"
    sudo apt-get install -y $pkgmissing
  fi
}


git_pull () {
  while read data; do
    echo_subsection "$data"
    git -C $data config --get remote.origin.url
    git -C $data pull
  done
}

git_pull_recursively () {
  # Finds subfolders that are git repositories,
  # and pulls the latest updates, using the git_pull function above.
  find . -name ".git" -type d | sed 's/\/.git//' | git_pull
}
