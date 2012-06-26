set :default_environment, default_environment.merge('RUBY_APP_CONFIGURATION'        => 'staging',
                                                    'PATH'                          => '$PATH:/home/ec2-user/ruby/bin')
set :branch,              'staging'
set :user,                'ec2-user'

role :data,         get_instance_public_dns('i-fb90259e')
role :application,  get_instance_public_dns('i-fb90259e')
