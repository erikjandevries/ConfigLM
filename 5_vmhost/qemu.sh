echo_section "Virtualisation"

echo_subsection "Checking if running in a Virtual Machine"
ensure_pkg virt-what

if [[ $(sudo virt-what) ]]; then
  echo_warn "Running in a virtual machine"
  echo "Configure virtual machines in the host"
else
  echo_info "Running bare metal"
  echo "Preparing for Qemu/KVM virtual machine hosting"

  echo_subsection "Installing qemu"
  ensure_pkg qemu-system qemu-utils

  echo_subsection "Installing virt-manager"
  ensure_pkg libvirt-bin virt-manager

  echo_subsection "Installing SPICE for KVM and virt-viewer"
  ensure_pkg python-spice-client-gtk virt-viewer
fi
