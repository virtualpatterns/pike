require 'bundler/capistrano'
require 'AWS'

def get_instance_public_dns(instance)
  service = AWS::EC2::Base.new(:access_key_id =>      ENV['AMAZON_ACCESS_KEY'],
                               :secret_access_key =>  ENV['AMAZON_SECRET_KEY'])
  response = service.describe_instances(:instance_id => instance)
  response.reservationSet.item[0].instancesSet.item[0].dnsName
end

set :servers,             1
set :default_environment, {
                            'AMAZON_ACCESS_KEY'   => ENV['AMAZON_ACCESS_KEY'],
                            'AMAZON_SECRET_KEY'   => ENV['AMAZON_SECRET_KEY']
                          }

set :stages,              %w[development staging production]
set :default_stage,       'development'
require 'capistrano/ext/multistage'

set :scm,                 :git
set :repository,          'git@github.com:virtualpatterns/pike.git'

set :deploy_to,           '/var/www/pike'
set :deploy_via,          :remote_cache

default_run_options[:pty] = true
