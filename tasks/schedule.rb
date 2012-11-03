job_type :rake, 'cd :path; mkdir -p ./process/cron/log; PATH=:PATH bundle exec rake :task --silent :output'

every :day, :at => '12:30AM' do
  rake 'pike:data:log:rotate',  :output => './process/cron/log/rotate.log'
end

every :hour do
  rake 'pike:data:backup',      :output => './process/cron/log/backup.log'
end
