echo_section "Private pre-installation configuration"

echo_subsection "Relocate folders using symbolic links"
DATA_ROOT=

# Make sure that the actual folders exist
ensure_dir $DATA_ROOT/Repositories -sudo
ensure_dir $DATA_ROOT/Software -sudo
ensure_dir $DATA_ROOT/VirtualEnvs -sudo

# Create symbolic links to the folders in the correct location
ensure_sl $DATA_ROOT/Repositories ~/Repositories
ensure_sl $DATA_ROOT/Software ~/Software
ensure_sl $DATA_ROOT/VirtualEnvs ~/VirtualEnvs

# echo_subsection "Git configuration"
# sudo apt-get install -y git
# git config --global user.name "My Name"
# git config --global user.email "my.email@host.com"
