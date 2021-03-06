set :servers,             3
set :default_environment, default_environment.merge('GITHUB_ACCESS_KEY'       => ENV['PIKE_DEVELOPMENT_GITHUB_ACCESS_KEY'],
                                                    'GITHUB_SECRET_KEY'       => ENV['PIKE_DEVELOPMENT_GITHUB_SECRET_KEY'],
                                                    'FACEBOOK_ACCESS_KEY'     => ENV['PIKE_DEVELOPMENT_FACEBOOK_ACCESS_KEY'],
                                                    'FACEBOOK_SECRET_KEY'     => ENV['PIKE_DEVELOPMENT_FACEBOOK_SECRET_KEY'],
                                                    'RUBY_APP_CONFIGURATION'  => 'development')
set :branch,              'development'
set :user,                'fficnar'

role :data,               'development.virtualpatterns.com'
role :application,        'development.virtualpatterns.com'
