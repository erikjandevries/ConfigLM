echo_section "Preparing for Qemu/KVM virtual machine hosting"

echo_subsection "Installing qemu"
ensure_pkg qemu-system qemu-utils

echo_subsection "Installing virt-manager"
ensure_pkg libvirt-bin virt-manager

echo_subsection "Installing SPICE for KVM and virt-viewer"
ensure_pkg python-spice-client-gtk virt-viewer
