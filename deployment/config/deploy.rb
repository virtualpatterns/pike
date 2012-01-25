require 'bundler/capistrano'
require 'AWS'

def get_ec2(access_key_id, secret_access_key)
  AWS::EC2::Base.new(:access_key_id => access_key_id,
                     :secret_access_key => secret_access_key)
end

def get_ec2_public_dns(access_key_id, secret_access_key, instance_id)

  ec2 = get_ec2(access_key_id, secret_access_key)

  response = ec2.describe_instances(:instance_id => instance_id)
  response.reservationSet.item[0].instancesSet.item[0].dnsName

end

def get_ec2_private_dns(access_key_id, secret_access_key, instance_id)

  ec2 = get_ec2(access_key_id, secret_access_key)

  response = ec2.describe_instances(:instance_id => instance_id)
  response.reservationSet.item[0].instancesSet.item[0].privateDnsName

end

set :access_key,    ENV['AMAZON_ACCESS_KEY']
set :secret_key,    ENV['AMAZON_SECRET_KEY']

set :servers,       1

set :stages,        %w[staging development development_ree]
set :default_stage, 'development'
require 'capistrano/ext/multistage'

set :scm,           :git
set :repository,    'git@github.com:virtualpatterns/pike.git'

set :deploy_to,     '/var/www/pike'
set :deploy_via,    :remote_cache

default_run_options[:pty] = true
