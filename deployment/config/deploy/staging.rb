set :servers,             3
set :default_environment, default_environment.merge('FACEBOOK_ACCESS_KEY'     => ENV['PIKE_STAGING_FACEBOOK_ACCESS_KEY'],
                                                    'FACEBOOK_SECRET_KEY'     => ENV['PIKE_STAGING_FACEBOOK_SECRET_KEY'],
                                                    'RUBY_APP_CONFIGURATION'  => 'staging',
                                                    'PATH'                    => '$PATH:/home/ec2-user/ruby/bin')
set :branch,              'staging'
set :user,                'ec2-user'

role :data,         get_instance_public_dns('i-fb90259e')
role :application,  get_instance_public_dns('i-fb90259e')
