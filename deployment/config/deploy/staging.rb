set :servers,             3
set :default_environment, default_environment.merge('GITHUB_ACCESS_KEY'       => ENV['PIKE_STAGING_GITHUB_ACCESS_KEY'],
                                                    'GITHUB_SECRET_KEY'       => ENV['PIKE_STAGING_GITHUB_SECRET_KEY'],
                                                    'FACEBOOK_ACCESS_KEY'     => ENV['PIKE_STAGING_FACEBOOK_ACCESS_KEY'],
                                                    'FACEBOOK_SECRET_KEY'     => ENV['PIKE_STAGING_FACEBOOK_SECRET_KEY'],
                                                    'RUBY_APP_CONFIGURATION'  => 'staging',
                                                    'PATH'                    => '$PATH:/home/ec2-user/ruby/bin')
set :branch,              'staging'
set :user,                'ec2-user'

role :data,         get_instance_public_dns('i-fb90259e')
role :application,  get_instance_public_dns('i-fb90259e')

# For native extensions that won't install via bundle install, go to the ...
# /var/www/pike/shared/bundle/ruby/1.8 
# ... directory and execute ...
# (sudo not required)
# gem install <gem> -v '<version>' -i .
