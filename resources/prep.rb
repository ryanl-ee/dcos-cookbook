actions :prep
default_action :prep

action :prep do
  packages = %w(tar xz unzip curl ipset)

  packages.each do |pkg|
    package pkg
  end

  group 'nogroup'

  # Disable IPv6
  include_recipe 'sysctl::default'

  sysctl_param 'net.ipv6.conf.all.disable_ipv6' do
    value 1
  end

  sysctl_param 'net.ipv6.conf.default.disable_ipv6' do
    value 1
  end

  include_recipe 'selinux::_common'

  selinux_state 'SELinux Disabled' do
    action :disabled
  end

  # Currently needs a reboot to permanently disable SELinux/IPv6
  # otherwise Docker will refuse to start even if it is Permissive
  reboot 'disable_selinux' do
    action :reboot_now
    not_if 'getenforce | grep Disabled'
  end
end
