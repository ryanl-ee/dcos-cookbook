default['dcos']['cluster_name'] = 'DCOS'

# configure your bootstrap node here
default['dcos']['bootstrap']['protocol'] = 'http://'
default['dcos']['bootstrap']['address'] = '192.168.33.10'
default['dcos']['bootstrap']['port'] = '9090'
default['dcos']['bootstrap']['url'] = "#{node['dcos']['bootstrap']['protocol']}#{node['dcos']['bootstrap']['address']}:#{node['dcos']['bootstrap']['port']}"
default['dcos']['bootstrap']['data_path'] = '/opt/dcos/tmp'
default['dcos']['bootstrap']['config_script_url'] = 'https://downloads.dcos.io/dcos/EarlyAccess/dcos_generate_config.sh'

default['dcos']['role'] = 'slave'

default['dcos']['master_list'] = []

# allowed values: zookeeper, aws_s3, shared_filesystem
default['dcos']['exhibitor']['storage_backend'] = 'shared_filesystem'
default['dcos']['exhibitor']['fs_config_dir'] = '/var/run/exhibitor'
default['dcos']['exhibitor']['zk_hosts'] = []

default['dcos']['dns']['search'] = 'dcos.test'
default['dcos']['dns']['resolvers'] = [] # if you have no internal DNS, use something public like 8.8.8.8
