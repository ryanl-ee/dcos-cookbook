require 'spec_helper'

if node['run_list'].include? 'recipe[dcos_tester::slave]'
  describe 'slave' do
    describe service 'dcos-mesos-slave' do
      it { should be_enabled }
      it { should be_running }
    end
  end
end
