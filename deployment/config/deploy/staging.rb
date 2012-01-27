set :servers,       3
set :configuration, 'staging'

set :branch,        'staging'

set :instance_id,   'i-9e08ccfc'
set :public_dns,    get_ec2_public_dns(access_key, secret_key, instance_id)
set :private_dns,   get_ec2_private_dns(access_key, secret_key, instance_id)

set :user, 'ec2-user'

role :server,       public_dns
