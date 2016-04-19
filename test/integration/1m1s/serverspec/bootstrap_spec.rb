require 'spec_helper'

if node['run_list'].include? 'recipe[dcos_tester::bootstrap]'
  describe 'bootstrap' do
    describe file('/opt/dcos/tmp/genconf/config.yaml') do
      it { should be_file }
    end

    describe file('/opt/dcos/tmp/genconf/ip-detect') do
      it { should be_file }
    end

    describe file('/opt/dcos/tmp/dcos_generate_config.sh') do
      it { should be_file }
    end

    describe file('/opt/dcos/tmp/genconf/serve/dcos_install.sh') do
      it { should be_file }
    end

    describe package('python') do
      it { should be_installed }
    end

    describe service('dcos-bootstrap') do
      it { should be_enabled }
      it { should be_running }
    end
  end
end
