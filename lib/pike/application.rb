require 'rubygems'
require 'bundler/setup'

require 'mongoid'
require 'sass/plugin'

require 'ruby_app/application'
require 'ruby_app/themes/mobile'

module Pike

  class Application < RubyApp::Application

    attr_reader :connection

    def initialize(options)
      super(options)
    end

    def start!
      super

      RubyApp::Log.debug("#{self.class}##{__method__}")

      Sass::Plugin.options[:load_paths] += [File.expand_path(File.join(File.dirname(__FILE__), %w[elements]))]

      @connection = Mongo::Connection.new(Pike::Application.configure.mongoid.host,
                                          Pike::Application.configure.mongoid.port)

      Mongoid.configure do |config|
        config.master = @connection.db(Pike::Application.configure.mongoid.database)
      end

    end

    def drop_database!
      @connection.drop_database(Pike::Application.configure.mongoid.database)
    end

    def self.create_default!

      require 'pike/application'
      require 'pike/session'
      require 'pike/version'

      options = { :application_class => Pike::Application,
                  :session_class => Pike::Session,
                  :log_path => File.join(Pike::ROOT, %w[log application.log]),
                  :configuration_paths => File.join(Pike::ROOT, %w[config.yml]),
                  :default_language => :en,
                  :translations_paths => File.join(Pike::ROOT, %w[translations]) }

      Pike::Application.create! options

    end

  end

end
