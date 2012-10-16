set :servers,             3
set :default_environment, default_environment.merge('FACEBOOK_ACCESS_KEY'     => ENV['PIKE_DEVELOPMENT_FACEBOOK_ACCESS_KEY'],
                                                    'FACEBOOK_SECRET_KEY'     => ENV['PIKE_DEVELOPMENT_FACEBOOK_SECRET_KEY'],
                                                    'RUBY_APP_CONFIGURATION'  => 'development',
                                                    'PATH'                    => '$PATH:/opt/ruby/bin')
set :branch,              'development'
set :user,                'fficnar'

role :data,         'rhombus.zapto.org:3022'
role :application,  'rhombus.zapto.org:3022'
