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

  end

end
