#
# Cookbook Name:: dcos
# Recipe:: bootstrap
#
# Copyright (c) 2016 Ryan Lee, All Rights Reserved.

include_recipe 'dcos::_prep'

include_recipe 'dcos::_docker'

dcos_bootstrap node['dcos']['cluster_name'] do
  config_script_url node['dcos']['bootstrap']['config_script_url']
  master_list node['dcos']['master_list']
  zk_hosts node['dcos']['exhibitor']['zk_hosts']
  bootstrap_url node['dcos']['bootstrap']['url']
  dns_resolvers node['dcos']['dns']['resolvers']
  dns_search node['dcos']['dns']['search']
end
