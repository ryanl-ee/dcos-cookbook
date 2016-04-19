require 'spec_helper'

if node['run_list'].include? 'recipe[dcos_tester::master]'
  describe 'master' do
    %w(dcos-mesos-dns dcos-history-service dcos-nginx dcos-mesos-master dcos-exhibitor dcos-marathon).each do |srv|
      describe service srv do
        it { should be_enabled }
        it { should be_running }
      end
    end
  end
end
