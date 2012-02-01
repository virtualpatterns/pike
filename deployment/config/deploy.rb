require 'bundler/capistrano'
require 'AWS'

def get_instance_public_dns(access_key_id, secret_access_key, instance_id)
  service = AWS::EC2::Base.new(:access_key_id => access_key_id,
                               :secret_access_key => secret_access_key)
  response = service.describe_instances(:instance_id => instance_id)
  response.reservationSet.item[0].instancesSet.item[0].dnsName
end

set :access_key,    ENV['AMAZON_ACCESS_KEY']
set :secret_key,    ENV['AMAZON_SECRET_KEY']

set :servers,       3
set :configuration, 'default'
set :branch,        'development'

set :stages,        %w[production staging development]
set :default_stage, 'development'
require 'capistrano/ext/multistage'

set :scm,           :git
set :repository,    'git@github.com:virtualpatterns/pike.git'

set :deploy_to,     '/var/www/pike'
set :deploy_via,    :remote_cache

default_run_options[:pty] = true
