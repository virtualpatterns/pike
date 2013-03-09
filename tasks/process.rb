require 'rubygems'
require 'bundler/setup'

require 'daemons'

namespace :pike do

  namespace :process do

    desc 'Create a console'
    task :console do |task|
      system('bundle exec irb -r ./console.rb --back-trace-limit 100')
    end

    namespace :database do

      desc 'Start MongoDB'
      task :start do |task|
        puts "Starting ..."
        system('mkdir -p ./process/mongodb/data; mkdir -p ./process/mongodb/log; mongod --dbpath ./process/mongodb/data --logpath ./process/mongodb/log/mongodb.log --verbose --fork')
      end

    end

    namespace :daemon do

      desc 'Start the daemon'
      task :start do |task|
        puts "Starting ..."
        run_daemon(['start'])
      end

      desc 'Stop the daemon'
      task :stop do |task|
        puts "Stopping ..."
        run_daemon(['stop'])
      end

      desc 'Restart the daemon'
      task :restart => ['pike:process:daemon:stop',
                        'pike:process:daemon:start']

      def run_daemon(arguments)
        pid_path = File.join(File.dirname(__FILE__), %w[.. process piked pid])
        FileUtils.mkdir_p(pid_path)
        log_path = File.join(File.dirname(__FILE__), %w[.. process piked log])
        FileUtils.mkdir_p(log_path)
        Daemons.run(File.join(File.dirname(__FILE__), %w[.. lib pike daemon.rb]),  :app_name   => 'piked',
                                                                                   :ARGV       => arguments,
                                                                                   :dir_mode   => :normal,
                                                                                   :dir        => pid_path,
                                                                                   :multiple   => false,
                                                                                   :mode       => :load,
                                                                                   :backtrace  => true,
                                                                                   :monitor    => false,
                                                                                   :log_dir    => log_path)
      end

    end

    namespace :server do

      desc 'Start the server(s)'
      task :start, :_count do |task, arguments|
        _count = arguments._count ? arguments._count.to_i : 1
        puts "Starting #{_count} server(s) ..."
        system("#{_count == 1 ? 'rm -f ./process/thin/pid/thin.pid' : 'rm -f ./process/thin/pid/thin.*.pid'}; bundle exec thin --port 8000 #{_count > 1 ? "--servers #{_count}" : nil} --rackup configuration.ru --daemonize --log ./process/thin/log/thin.log --pid ./process/thin/pid/thin.pid start")
      end

      desc 'Stop the server(s)'
      task :stop do |task|
        puts "Stopping ..."
        system('for pid in ./process/thin/pid/*.pid; do bundle exec thin --pid $pid stop; done')
      end

      desc 'Restart the server(s)'
      task :restart, [:_count] => ['pike:process:server:stop',
                                   'pike:process:server:start']

    end

    namespace :schedule do

      desc 'Install the schedule'
      task :install do |task|
        puts "Installing ..."
        system("bundle exec whenever --load-file ./tasks/schedule.rb --set 'RUBY_APP_CONFIGURATION=#{ENV['RUBY_APP_CONFIGURATION']}&PATH=#{ENV['PATH']}' --update-crontab pike")
      end

      desc 'Uninstall the schedule'
      task :uninstall do |task|
        puts "Uninstalling ..."
        system("bundle exec whenever --load-file ./tasks/schedule.rb --set 'RUBY_APP_CONFIGURATION=#{ENV['RUBY_APP_CONFIGURATION']}&PATH=#{ENV['PATH']}' --clear-crontab pike")
      end

    end

  end

end
