set :servers,             3
set :default_environment, default_environment.merge('GITHUB_ACCESS_KEY'       => ENV['PIKE_STAGING_GITHUB_ACCESS_KEY'],
                                                    'GITHUB_SECRET_KEY'       => ENV['PIKE_STAGING_GITHUB_SECRET_KEY'],
                                                    'FACEBOOK_ACCESS_KEY'     => ENV['PIKE_STAGING_FACEBOOK_ACCESS_KEY'],
                                                    'FACEBOOK_SECRET_KEY'     => ENV['PIKE_STAGING_FACEBOOK_SECRET_KEY'],
                                                    'RUBY_APP_CONFIGURATION'  => 'staging')
set :branch,              'staging'
set :user,                'ubuntu'

role :data,               'code.virtualpatterns.com' # get_instance_public_dns('i-da9aa9a9')
role :application,        'code.virtualpatterns.com' # get_instance_public_dns('i-da9aa9a9')

# For native extensions that won't install via bundle install, go to the ...
# /var/www/pike/shared/bundle/ruby/1.8 
# ... directory and execute ...
# (sudo not required)
# gem install <gem> -v '<version>' -i .
