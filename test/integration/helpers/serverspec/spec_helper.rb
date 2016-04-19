require 'serverspec'
require 'json'

if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM).nil?
  set :backend, :exec
else
  set :backend, :cmd
  set :os, family: 'windows'
end

def node
  JSON.parse(File.read('/tmp/kitchen/chef_node.json'))
end
