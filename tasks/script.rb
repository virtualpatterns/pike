namespace :pike do

  namespace :script do

    desc 'Start a given script using a given number of instances of PhantomJS on a given url'
    task :start, :url, :script, :_count do |task, arguments|
      Rake::Task['pike:script:log:destroy'].invoke(arguments.script)
      _count = arguments._count ? arguments._count.to_i : 1
      puts "Starting #{_count} instance(s), sending output to scripts/#{arguments.script}.log ..."
      (1.._count).each do |count|
        system("phantomjs --ignore-ssl-errors=true scripts/phantom/phantom.js #{arguments.url} #{arguments.script} 1>> scripts/#{arguments.script}.log 2>> /dev/null &")
      end
    end

    namespace :log do

      desc 'Destroy the log for a given script'
      task :destroy, :script do |task, arguments|
        system("rm scripts/#{arguments.script}.log")
      end

      desc 'Monitor the log for a given script'
      task :monitor, :script do |task, arguments|
        puts "Monitoring #{arguments.script}, CTRL+C to stop"
        system("tail -f scripts/#{arguments.script}.log")
      end

    end

    namespace :standard_no_logon do

      desc 'Start the script through PhantomJS on a given url'
      task :start, :url do |task, arguments|
        Rake::Task['pike:script:start'].invoke(arguments.url, 'phantom/standard_no_logon')
      end

      desc 'Start the script on the local environment'
      task :local do |task|
        Rake::Task['pike:script:standard_no_logon:start'].invoke('http://localhost:8000/pike')
      end

      desc 'Start the script on the development environment'
      task :development do |task|
        Rake::Task['pike:script:standard_no_logon:start'].invoke('https://development.virtualpatterns.com/pike')
      end

      desc 'Start the script on the staging environment'
      task :staging do |task|
        Rake::Task['pike:script:standard_no_logon:start'].invoke('https://code.virtualpatterns.com/pike')
      end

    end

    namespace :performance do

      desc 'Start the script using a given number of instances of PhantomJS on a given url'
      task :start, :url, :_count do |task, arguments|
        Rake::Task['pike:script:start'].invoke(arguments.url, 'phantom/performance', arguments._count)
        Rake::Task['pike:script:log:monitor'].invoke('phantom/performance')
      end

      desc 'Start the script on the local environment'
      task :local, :_count do |task, arguments|
        Rake::Task['pike:script:performance:start'].invoke('http://localhost:8000/pike', arguments._count)
      end

      desc 'Start the script on the development environment'
      task :development, :_count do |task, arguments|
        Rake::Task['pike:script:performance:start'].invoke('https://development.virtualpatterns.com/pike', arguments._count)
      end

      desc 'Start the script on the staging environment'
      task :staging, :_count do |task, arguments|
        Rake::Task['pike:script:performance:start'].invoke('https://code.virtualpatterns.com/pike', arguments._count)
      end

    end

    namespace :performance_continuous do

      desc 'Start the script using a given number of instances of PhantomJS on a given url'
      task :start, :url, :_count do |task, arguments|
        Rake::Task['pike:script:start'].invoke(arguments.url, 'phantom/performance_continuous', arguments._count)
        Rake::Task['pike:script:log:monitor'].invoke('phantom/performance_continuous')
      end

      desc 'Start the script on the local environment'
      task :local, :_count do |task, arguments|
        Rake::Task['pike:script:performance_continuous:start'].invoke('http://localhost:8000/pike', arguments._count)
      end

      desc 'Start the script on the development environment'
      task :development, :_count do |task, arguments|
        Rake::Task['pike:script:performance_continuous:start'].invoke('https://development.virtualpatterns.com/pike', arguments._count)
      end

      desc 'Start the script on the staging environment'
      task :staging, :_count do |task, arguments|
        Rake::Task['pike:script:performance_continuous:start'].invoke('https://code.virtualpatterns.com/pike', arguments._count)
      end

    end

  end

end
