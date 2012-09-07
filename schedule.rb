job_type :rake, 'cd :path; mkdir -p ./process/cron/log; PATH=:PATH RUBY_APP_CONFIGURATION=:RUBY_APP_CONFIGURATION bundle exec rake :task --silent :output'

every 1.hour do
  rake 'pike:data:backup', :output => './process/cron/log/backup.log'
end
