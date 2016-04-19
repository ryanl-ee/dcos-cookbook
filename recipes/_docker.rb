#
# Cookbook Name:: dcos
# Recipe:: _docker
#
# Copyright (c) 2016 Ryan Lee, All Rights Reserved.

directory '/etc/sysconfig' do
  recursive true
end

file '/etc/sysconfig/docker-storage-setup' do
  content <<-EOH
  DEVS=/dev/sdb
  VG=vg-docker
  SETUP_LVM_THIN_POOL=yes
  EOH
end

file '/etc/sysconfig/docker-storage' do
  content 'DOCKER_STORAGE_OPTIONS=--storage-driver devicemapper --storage-opt dm.fs=xfs'
end

package 'docker' do
  timeout 600
end

service 'docker' do
  action [:start, :enable]
end
