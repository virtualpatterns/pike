require 'bundler/capistrano'
require 'AWS'

def get_instance_public_dns(instance)
  puts "#{self.class}##{__method__} instance=#{instance.inspect}"
  puts "#{self.class}##{__method__} AWS::EC2::Base.new(:access_key_id => #{ENV['AMAZON_ACCESS_KEY'].inspect}, :secret_access_key => #{ENV['AMAZON_SECRET_KEY'].inspect})"
  service = AWS::EC2::Base.new(:access_key_id =>      ENV['AMAZON_ACCESS_KEY'],
                               :secret_access_key =>  ENV['AMAZON_SECRET_KEY'])
  response = service.describe_instances(:instance_id => instance)
  puts "#{self.class}##{__method__} response.reservationSet.item[0].instancesSet.item[0].dnsName=#{response.reservationSet.item[0].instancesSet.item[0].dnsName.inspect}"
  response.reservationSet.item[0].instancesSet.item[0].dnsName
end

set :servers,             3
set :default_environment, {
                            'AMAZON_ACCESS_KEY' => ENV['AMAZON_ACCESS_KEY'],
                            'AMAZON_SECRET_KEY' => ENV['AMAZON_SECRET_KEY']
                          }

set :stages,              %w[development staging_old staging_new production]
set :default_stage,       'development'
require 'capistrano/ext/multistage'

set :scm,                 :git
set :repository,          'git@github.com:virtualpatterns/pike.git'

set :deploy_to,           '/var/www/pike'
set :deploy_via,          :remote_cache

default_run_options[:pty] = true
