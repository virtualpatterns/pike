require 'rubygems'
require 'bundler/setup'

require 'ap'
require 'rake'

$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), %w[lib]))

require 'pike'
require 'pike/models'

require 'tasks/data'
require 'tasks/process'

$stdout.sync = true

namespace :pike do

  desc 'Print version information from Pike::VERSION'
  task :version do |task|
    puts Pike::VERSION
  end

  desc 'Display commit difference between current branch and staging'
  task :changes do |task|
    system("git checkout development; git pull origin development; git log --pretty=format:'%H %s' staging..HEAD")
  end

  desc 'Pull development, tag, push to development, and increment version'
  task :push do |task|
    system("git checkout development; git pull origin development; git tag -a -m 'Tag #{Pike::VERSION}' '#{Pike::VERSION}'; git push --tags origin development")
    version_file = File.join(Pike::ROOT, %w[lib pike version.rb])
    Pike::VERSION =~ /(\d+)\.(\d+)\.(\d+)/
    system("sed 's|[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*|#{$1}.#{$2}.#{$3.to_i + 1}|g' < '#{version_file}' > '#{version_file}.out'; rm '#{version_file}'; mv '#{version_file}.out' '#{version_file}'")
    system("git commit --all --message='Version #{$1}.#{$2}.#{$3.to_i + 1}'")
  end

  namespace :merge do

    desc 'Merge development and staging, push staging'
    task :staging do |task|
      system('git checkout staging; git pull origin staging; git merge origin/development; git push --tags origin staging; git checkout development')
    end

    desc 'Merge staging and production, push production'
    task :production do |task|
      system('git checkout production; git pull origin production; git merge origin/staging; git push --tags origin production; git checkout development')
    end

  end

  namespace :test do

    desc 'Run the test script through PhantomJS on a given url'
    task :url, :url do |task, arguments|
      system("phantomjs --ignore-ssl-errors=true scripts/phantom.js #{arguments.url}")
    end

    desc 'Run the test script on the local environment'
    task :local do |task|
      Rake::Task['pike:test:url'].invoke('http://localhost:8000/pike')
    end

    desc 'Run the test script on the development environment'
    task :development do |task|
      Rake::Task['pike:test:url'].invoke('http://development.virtualpatterns.com/pike')
    end

  end

  namespace :cache do

    desc 'List all cached files'
    task :list do
      system('find . | grep \'\\.cache\'')
    end

    desc 'Delete all cached files'
    task :destroy do
      puts 'Removing cached files ...'
      system('find . -name \'.cache\' | xargs rm -rv')
    end

  end

end
