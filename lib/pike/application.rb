require 'rubygems'
require 'bundler/setup'

require 'AWS'
require 'mongoid'

require 'ruby_app'

module Pike
  require 'pike/models/system/observers'

  class Application < RubyApp::Application

    attr_reader :connection

    def initialize
      super

      @connection = Mongo::Connection.new(Pike::Application.configuration.mongodb.host =~ /^i-/ ? Pike::Application.get_instance_private_dns(Pike::Application.configuration.mongodb.host) : Pike::Application.configuration.mongodb.host,
                                          Pike::Application.configuration.mongodb.port)

      Mongoid.configure do |config|
        config.master = @connection.db(Pike::Application.configuration.mongodb.database)
      end

      Mongoid.observers = Pike::System::Observers::ActivityObserver,
                          Pike::System::Observers::FriendshipObserver,
                          Pike::System::Observers::ProjectObserver,
                          Pike::System::Observers::PropertyObserver
      Mongoid.instantiate_observers

    end

    def drop_database!
      @connection.drop_database(Pike::Application.configuration.mongodb.database)
    end

    def self.create_context!
      super([ File.join(Pike::ROOT, %w[configuration.yml]),
              File.join(Pike::ROOT, %w[configuration.yml]) ])
    end

    def self.get_instance_private_dns(instance)
      RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} instance=#{instance.inspect}")
      RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} AWS::EC2::Base.new(:access_key_id => #{(ENV['AMAZON_ACCESS_KEY'] || Pike::Application.configuration.amazon.access_key).inspect}, :secret_access_key => #{(ENV['AMAZON_SECRET_KEY'] || Pike::Application.configuration.amazon.secret_key).inspect})")
      service = AWS::EC2::Base.new(:access_key_id     => ENV['AMAZON_ACCESS_KEY'] || Pike::Application.configuration.amazon.access_key,
                                   :secret_access_key => ENV['AMAZON_SECRET_KEY'] || Pike::Application.configuration.amazon.secret_key)
      response = service.describe_instances(:instance_id => instance)
      RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} response.reservationSet.item[0].instancesSet.item[0].privateDnsName=#{response.reservationSet.item[0].instancesSet.item[0].privateDnsName.inspect}")
      response.reservationSet.item[0].instancesSet.item[0].privateDnsName
    end

  end

end
