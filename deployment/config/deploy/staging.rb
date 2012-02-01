set :default_environment, default_environment.merge { 'RUBY_APP_CONFIGURATION' => 'staging' }
set :branch,              'staging'
set :user,                'ec2-user'

role :data,         get_instance_public_dns('i-9e08ccfc')
role :application,  get_instance_public_dns('i-9e08ccfc')
