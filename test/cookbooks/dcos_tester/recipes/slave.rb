include_recipe 'dcos::_prep'

include_recipe 'dcos_tester::_docker'

service 'firewalld' do
  action [:stop, :disable]
end

dcos 'slave' do
  install_script_url "#{node['dcos']['bootstrap']['url']}/dcos_install.sh"
end
