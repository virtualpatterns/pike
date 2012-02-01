require 'rubygems'
require 'bundler/setup'

require 'AWS'
require 'mongoid'
require 'sass/plugin'

require 'ruby_app/application'
require 'ruby_app/log'
require 'ruby_app/themes/mobile'

module Pike
  require 'pike/models/system/observers/activity_observer'
  require 'pike/models/system/observers/friendship_observer'
  require 'pike/models/system/observers/project_observer'

  class Application < RubyApp::Application

    attr_reader :connection

    def initialize(options)
      super(options)

      Sass::Plugin.options[:load_paths] += [File.expand_path(File.join(File.dirname(__FILE__), %w[elements]))]

      self.configuration.amazon.access_key = ENV['AMAZON_ACCESS_KEY'] if ENV['AMAZON_ACCESS_KEY']
      self.configuration.amazon.secret_key = ENV['AMAZON_SECRET_KEY'] if ENV['AMAZON_SECRET_KEY']

      self.configuration.mongodb.host = self.get_instance_private_dns(self.configuration.mongodb.host) if self.configuration.mongodb.host =~ /^i-/

      RubyApp::Log.debug("#{self.class}##{__method__} self.configuration.mongodb.host=#{self.configuration.mongodb.host.inspect}")
      RubyApp::Log.debug("#{self.class}##{__method__} self.configuration.mongodb.port=#{self.configuration.mongodb.port.inspect}")

      @connection = Mongo::Connection.new(self.configuration.mongodb.host,
                                          self.configuration.mongodb.port)

      Mongoid.configure do |config|
        config.master = @connection.db(self.configuration.mongodb.database)
      end

      Mongoid.observers = Pike::System::Observers::ActivityObserver,
                          Pike::System::Observers::FriendshipObserver,
                          Pike::System::Observers::ProjectObserver
      Mongoid.instantiate_observers

    end

    def get_instance_private_dns(instance)
      service = AWS::EC2::Base.new(:access_key_id => self.configuration.amazon.access_key,
                                   :secret_access_key => self.configuration.amazon.secret_key)
      response = service.describe_instances(:instance_id => instance)
      response.reservationSet.item[0].instancesSet.item[0].privateDnsName
    end

    def drop_database!
      @connection.drop_database(self.configuration.mongodb.database)
    end

    def self.create_default!

      require 'pike/application'
      require 'pike/session'
      require 'pike/version'

      options = { :application_class => Pike::Application,
                  :session_class => Pike::Session,
                  :log_path => File.join(Pike::ROOT, %w[process log application.log]),
                  :configuration_paths => File.join(Pike::ROOT, %w[config.yml]),
                  :default_language => :en,
                  :translations_paths => File.join(Pike::ROOT, %w[translations]) }

      Pike::Application.create! options

    end

  end

end
