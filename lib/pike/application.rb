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

      Sass::Plugin.options[:load_paths] += [File.expand_path(File.join(File.dirname(__FILE__), %w[elements]))]

      @connection = Mongo::Connection.new(Pike::Application.configuration.mongoid.host,
                                          Pike::Application.configuration.mongoid.port)

      Mongoid.configure do |config|
        config.master = @connection.db(Pike::Application.configuration.mongoid.database)
      end

    end

  end

end
