job_type :rake, 'cd :path; mkdir -p ./process/cron/log; PATH=:PATH bundle exec rake :task --silent :output'

every 1.hour do
  rake 'pike:data:backup', :output => './process/cron/log/backup.log'
end
