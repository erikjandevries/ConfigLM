echo_section "Preparing for Qemu/KVM virtual machine hosting"

echo_subsection "Installing qemu"
sudo apt-get install -y qemu-system
sudo apt-get install -y qemu-utils

echo_subsection "Installing virt-manager"
sudo apt-get install -y libvirt-bin
sudo apt-get install -y virt-manager

echo_subsection "Installing SPICE for KVM and virt-viewer"
sudo apt-get install -y python-spice-client-gtk
sudo apt-get install -y virt-viewer
