set :default_environment, default_environment.merge('RUBY_APP_CONFIGURATION'  => 'production',
                                                    'PATH'                    => '$PATH:/home/ec2-user/ruby/bin')
set :branch,              'production'
set :user,                'ec2-user'

role :data,         get_instance_public_dns('i-51d50f34')
role :application,  get_instance_public_dns('i-cf8c22aa')
