namespace :pike do

  namespace :script do

    desc 'Run a given script through PhantomJS on a given url'
    task :run, :url, :script do |task, arguments|
      system("phantomjs --ignore-ssl-errors=true scripts/phantom/phantom.js #{arguments.url} #{arguments.script}")
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

    end

    namespace :performance do

      desc 'Run the script through PhantomJS on a given url'
      task :run, :url do |task, arguments|
        Rake::Task['pike:script:run'].invoke(arguments.url, 'phantom/performance')
      end

      desc 'Run the script on the local environment'
      task :local do |task|
        Rake::Task['pike:script:performance:run'].invoke('http://localhost:8000/pike')
      end

      desc 'Run the script on the development environment'
      task :development do |task|
        Rake::Task['pike:script:performance:run'].invoke('https://development.virtualpatterns.com/pike')
      end

    end

    namespace :performance_continuous do

      desc 'Run the script through PhantomJS on a given url'
      task :run, :url do |task, arguments|
        Rake::Task['pike:script:run'].invoke(arguments.url, 'phantom/performance_continuous')
      end

      desc 'Run the script on the local environment'
      task :local do |task|
        Rake::Task['pike:script:performance_continuous:run'].invoke('http://localhost:8000/pike')
      end

      desc 'Run the script on the development environment'
      task :development do |task|
        Rake::Task['pike:script:performance_continuous:run'].invoke('https://development.virtualpatterns.com/pike')
      end

    end

  end

end
