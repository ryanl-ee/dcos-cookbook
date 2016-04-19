attribute :cluster_name, name_attribute: true, kind_of: String, required: true
attribute :config_script_url, kind_of: String, required: true
attribute :bootstrap_url, kind_of: String, required: true
attribute :data_path, kind_of: String, required: false, default: '/opt/dcos/tmp'
attribute :dns_resolvers, kind_of: Array, required: false, default: ['8.8.8.8', '8.8.4.4']
attribute :dns_search, kind_of: String, required: false, default: 'dcos.test'
attribute :master_list, kind_of: Array, required: true
attribute :storage_backend, kind_of: String, required: false, default: 'zookeeper'
attribute :zk_hosts, kind_of: Array, required: true

actions :create
default_action :create

action :create do
  python_path = '/bin/python'
  systemd_path = '/usr/lib/systemd/system'

  directory data_path + '/genconf' do
    recursive true
  end

  template data_path + '/genconf/config.yaml' do
    source 'config.yaml.erb'
    variables(bootstrap_url: bootstrap_url,
              cluster_name: cluster_name,
              config_script_url: config_script_url,
              data_path: data_path,
              dns_resolvers: dns_resolvers,
              dns_search: dns_search,
              master_list: master_list,
              storage_backend: storage_backend,
              zk_hosts: zk_hosts)
  end

  template data_path + '/genconf/ip-detect' do
    source 'ip-detect.erb'
    variables(master_list: master_list)
  end

  remote_file data_path + '/dcos_generate_config.sh' do
    source config_script_url
  end

  execute 'generate_config' do
    cwd data_path
    command 'bash dcos_generate_config.sh'
    creates data_path + '/genconf/serve/dcos_install.sh'
  end

  package 'python'

  template "#{systemd_path}/dcos-bootstrap.service" do
    source 'dcos-bootstrap.service.erb'
    variables(data_path: data_path,
              python_path: python_path)
  end

  service 'dcos-bootstrap' do
    action [:enable, :start]
  end
end
