set :configuration, 'production'
set :branch,        'production'
set :user,          'ec2-user'

role :data,         get_ec2_public_dns(access_key, secret_key, 'i-51d50f34')
role :application,  get_ec2_public_dns(access_key, secret_key, 'i-51d50f34')
