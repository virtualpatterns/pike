set :default_environment, default_environment.merge('RUBY_APP_CONFIGURATION' => 'default')
set :branch,              'development'
set :user,                'fficnar'

role :data,         'rhombus.zapto.org:4022'
role :application,  'rhombus.zapto.org:4022'
