#
# Cookbook Name:: dcos
# Recipe:: default
#
# Copyright (c) 2016 Ryan Lee, All Rights Reserved.

include_recipe 'dcos::_prep'

include_recipe 'dcos::_docker'

dcos node['dcos']['role'] do
  install_script_url "#{node['dcos']['bootstrap']['url']}/dcos_install.sh"
end
