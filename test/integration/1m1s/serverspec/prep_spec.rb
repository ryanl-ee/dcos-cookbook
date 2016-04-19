require 'spec_helper'

describe 'prep' do
  %w(tar xz unzip curl ipset).each do |pkg|
    describe package pkg do
      it { should be_installed }
    end
  end

  describe service('docker') do
    it { should be_enabled }
    it { should be_running }
  end

  describe group('nogroup') do
    it { should exist }
  end

  describe command('sysctl -a') do
    its(:stdout) { should match /disable_ipv6/ }
  end

  describe service('firewalld') do
    it { should_not be_enabled }
    it { should_not be_running }
  end

  describe selinux do
    it { should be_disabled }
  end
end
