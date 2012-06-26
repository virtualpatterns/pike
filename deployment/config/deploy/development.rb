set :default_environment, default_environment.merge('RUBY_APP_CONFIGURATION'        => 'development',
                                                    'PATH'                          => '$PATH:/opt/ruby/bin')
set :branch,              'development'
set :user,                'fficnar'

role :data,         'rhombus.zapto.org:3022'
role :application,  'rhombus.zapto.org:3022'
