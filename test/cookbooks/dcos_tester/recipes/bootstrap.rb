include_recipe 'dcos::_prep'

include_recipe 'dcos_tester::_docker'

service 'firewalld' do
  action [:stop, :disable]
end

dcos_bootstrap node['dcos']['cluster_name'] do
  config_script_url node['dcos']['bootstrap']['config_script_url']
  master_list node['dcos']['master_list']
  zk_hosts node['dcos']['exhibitor']['zk_hosts']
  bootstrap_url node['dcos']['bootstrap']['url']
end
