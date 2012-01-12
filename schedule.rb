job_type :rake, 'cd :path && bundle exec rake :task --quiet :output'

every 1.minutes do
  rake "pike:data:actions:process_all", :output => { :error => 'log/actions.err', :standard => 'log/actions.log' }
end
