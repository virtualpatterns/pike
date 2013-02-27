require 'rubygems'
require 'bundler/setup'

require 'daemons'

namespace :pike do

  namespace :process do

    desc 'Create a console'
    task :console do |task|
      system('clear; bundle exec ruby_app console')
    end

    namespace :mongodb do

      desc 'Start MongoDB'
      task :start do |task|
        system('mkdir -p ./process/mongodb/data; mkdir -p ./process/mongodb/log; mongod --dbpath ./process/mongodb/data --logpath ./process/mongodb/log/mongodb.log --verbose --fork')
      end

    end

    namespace :daemon do

      desc 'Start the daemon'
      task :start do |task|
        run_daemon(['start'])
      end

      desc 'Stop the daemon'
      task :stop do |task|
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

    namespace :thin do

      desc 'Start the server(s)'
      task :start, :daemonize, :servers do |task, arguments|
        daemonize = arguments.daemonize ? arguments.daemonize.to_b : true
        servers = arguments.servers ? arguments.servers.to_i : 1
        system("#{servers == 1 ? 'rm -f ./process/thin/pid/thin.pid' : 'rm -f ./process/thin/pid/thin.*.pid'}; #{daemonize ? nil : 'clear; '} bundle exec thin --port 8000 #{servers > 1 ? "--servers #{servers}" : nil} --rackup configuration.ru #{daemonize && servers ? '--daemonize' : nil} --log ./process/thin/log/thin.log --pid ./process/thin/pid/thin.pid start")
      end

      desc 'Start with coverage'
      task :start_with_coverage do |task|
        system("rm -f ./process/thin/pid/thin.pid; clear; bundle exec rcov --output ./coverage --sort coverage --threshold 100 --exclude /.rvm #{ENV['GEM_HOME']}/bin/thin -- --port 8000 --rackup configuration.ru --log ./process/thin/log/thin.log --pid ./process/thin/pid/thin.pid start; open ./coverage/index.html")
      end

      desc 'Stop the server(s)'
      task :stop do |task|
        system('for pid in ./process/thin/pid/thin.*.pid; do bundle exec thin --pid $pid stop; done')
      end

      desc 'Restart the server(s)'
      task :restart => ['pike:process:thin:stop',
                        'pike:process:thin:start']

    end

    namespace :cron do

      desc 'Install the schedule'
      task :install do |task|
        system("bundle exec whenever --load-file ./tasks/schedule.rb --set 'RUBY_APP_CONFIGURATION=#{ENV['RUBY_APP_CONFIGURATION']}&PATH=#{ENV['PATH']}' --update-crontab pike")
      end

      desc 'Uninstall the schedule'
      task :uninstall do |task|
        system("bundle exec whenever --load-file ./tasks/schedule.rb --set 'RUBY_APP_CONFIGURATION=#{ENV['RUBY_APP_CONFIGURATION']}&PATH=#{ENV['PATH']}' --clear-crontab pike")
      end

    end

  end

end
