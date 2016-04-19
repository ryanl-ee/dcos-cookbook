attribute :role, name_attribute: true, kind_of: String, required: true
attribute :install_script_url, kind_of: String, required: true
attribute :data_path, kind_of: String, required: false, default: '/opt/dcos/tmp'

actions :install
default_action :install

action :install do
  directory data_path do
    recursive true
  end

  remote_file data_path + '/dcos_install.sh' do
    source install_script_url
    retries 120
    retry_delay 30
  end

  execute 'install_dcos' do
    cwd data_path
    command "bash dcos_install.sh #{role}"
    creates '/opt/mesosphere/environment'
  end
end
