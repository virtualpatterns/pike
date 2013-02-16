set :servers,             10
set :default_environment, default_environment.merge('GITHUB_ACCESS_KEY'       => ENV['PIKE_PRODUCTION_GITHUB_ACCESS_KEY'],
                                                    'GITHUB_SECRET_KEY'       => ENV['PIKE_PRODUCTION_GITHUB_SECRET_KEY'],
                                                    'FACEBOOK_ACCESS_KEY'     => ENV['PIKE_PRODUCTION_FACEBOOK_ACCESS_KEY'],
                                                    'FACEBOOK_SECRET_KEY'     => ENV['PIKE_PRODUCTION_FACEBOOK_SECRET_KEY'],
                                                    'RUBY_APP_CONFIGURATION'  => 'production',
                                                    'PATH'                    => '$PATH:/home/ec2-user/ruby/bin')
set :branch,              'production'
set :user,                'ec2-user'

role :data,               get_instance_public_dns('i-51d50f34')
role :application,        get_instance_public_dns('i-cf8c22aa')
