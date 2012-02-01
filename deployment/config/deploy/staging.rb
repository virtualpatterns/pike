set :configuration, 'staging'
set :branch,        'staging'
set :user,          'ec2-user'

role :data,         get_ec2_public_dns(access_key, secret_key, 'i-9e08ccfc')
role :application,  get_ec2_public_dns(access_key, secret_key, 'i-9e08ccfc')
