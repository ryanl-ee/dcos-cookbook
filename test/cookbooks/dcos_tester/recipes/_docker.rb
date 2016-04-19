directory '/etc/sysconfig' do
  recursive true
end

file '/etc/sysconfig/docker-storage' do
  content 'DOCKER_STORAGE_OPTIONS= -s overlay'
end

package 'docker' do
  timeout 600
end

service 'docker' do
  action [:start, :enable]
end
