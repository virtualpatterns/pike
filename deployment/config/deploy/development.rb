set :default_environment, default_environment.merge('RUBY_APP_CONFIGURATION'  => 'default',
                                                    'PATH'                    => '$PATH:/opt/ruby/bin')
set :branch,              'development'
set :user,                'fficnar'
set :servers,             1

role :data,         'rhombus.zapto.org:3022'
role :application,  'rhombus.zapto.org:3022'
