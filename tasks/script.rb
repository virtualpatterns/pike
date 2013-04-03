namespace :pike do

  namespace :script do

    desc 'Run a given script using a given number of instances of PhantomJS on a given url'
    task :run, :url, :script, :_count do |task, arguments|
      _count = arguments._count ? arguments._count.to_i : 1
      puts "Starting #{_count} instance(s), sending output to scripts/#{arguments.script}.log ..." if _count > 1
      (1.._count).each do |count|
        system("phantomjs --ignore-ssl-errors=true scripts/phantom/phantom.js #{arguments.url} #{arguments.script} #{_count <= 1 ? '' : "1>> scripts/#{arguments.script}.log 2>> /dev/null &"}")
      end
    end

    namespace :standard_no_logon do

      desc 'Run the script through PhantomJS on a given url'
      task :run, :url do |task, arguments|
        Rake::Task['pike:script:run'].invoke(arguments.url, 'phantom/standard_no_logon')
      end

      desc 'Run the script on the local environment'
      task :local do |task|
        Rake::Task['pike:script:standard_no_logon:run'].invoke('http://localhost:8000/pike')
      end

      desc 'Run the script on the development environment'
      task :development do |task|
        Rake::Task['pike:script:standard_no_logon:run'].invoke('https://development.virtualpatterns.com/pike')
      end

      desc 'Run the script on the staging environment'
      task :staging do |task|
        Rake::Task['pike:script:standard_no_logon:run'].invoke('https://code.virtualpatterns.com/pike')
      end

    end

    namespace :performance do

      desc 'Run the script using a given number of instances of PhantomJS on a given url'
      task :run, :url, :_count do |task, arguments|
        _count = arguments._count ? arguments._count.to_i : 1
        if _count > 1
          system("rm scripts/phantom/performance.log")
        end
        Rake::Task['pike:script:run'].invoke(arguments.url, 'phantom/performance', _count)
        if _count > 1
          system("tail -f scripts/phantom/performance.log")
          system("cat scripts/phantom/performance.log | scripts/phantom/performance.awk")
        end
      end

      desc 'Run the script on the local environment'
      task :local, :_count do |task, arguments|
        Rake::Task['pike:script:performance:run'].invoke('http://localhost:8000/pike', arguments._count)
      end

      desc 'Run the script on the development environment'
      task :development, :_count do |task, arguments|
        Rake::Task['pike:script:performance:run'].invoke('https://development.virtualpatterns.com/pike', arguments._count)
      end

      desc 'Run the script on the staging environment'
      task :staging, :_count do |task, arguments|
        Rake::Task['pike:script:performance:run'].invoke('https://code.virtualpatterns.com/pike', arguments._count)
      end

    end

    namespace :performance_continuous do

      desc 'Run the script using a given number of instances of PhantomJS on a given url'
      task :run, :url, :_count do |task, arguments|
        Rake::Task['pike:script:run'].invoke(arguments.url, 'phantom/performance_continuous', arguments._count)
      end

      desc 'Run the script on the local environment'
      task :local, :_count do |task, arguments|
        Rake::Task['pike:script:performance_continuous:run'].invoke('http://localhost:8000/pike', arguments._count)
      end

      desc 'Run the script on the development environment'
      task :development, :_count do |task, arguments|
        Rake::Task['pike:script:performance_continuous:run'].invoke('https://development.virtualpatterns.com/pike', arguments._count)
      end

      desc 'Run the script on the staging environment'
      task :staging, :_count do |task, arguments|
        Rake::Task['pike:script:performance_continuous:run'].invoke('https://code.virtualpatterns.com/pike', arguments._count)
      end

    end

  end

end
