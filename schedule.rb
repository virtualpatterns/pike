job_type :rake, 'cd :path && bundle exec rake :task :output'

every 1.minutes do
  rake "pike:data:actions:process_all", :output => { :standard => 'log/pike_data_actions_process_all.log', :error => 'log/pike_data_actions_process_all.error.log' }
end
