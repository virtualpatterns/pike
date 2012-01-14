job_type :rake, 'cd :path && rake :task :output'

every 1.minutes do
  rake "pike:data:actions:process_all", :output => { :standard => 'log/actions.log', :error => 'log/actions.error.log' }
end
