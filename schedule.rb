job_type :rake, 'cd :path; mkdir -p ./process/cron/log; bundle exec rake :task --silent :output'

every 1.minute do
  rake    'pike:data:backup', :output => './process/cron/log/backup.log'
end
