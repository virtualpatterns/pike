require 'rubygems'
require 'bundler/setup'

require 'AWS'
require 'mongoid'

require 'ruby_app'

module Pike
  require 'pike/models/system/observers'

  class Application < RubyApp::Application

    def initialize
      super

      Mongoid.configure do |configuration|
        configuration.sessions  = Pike::Application.configuration.mongodb.sessions
        configuration.options   = Pike::Application.configuration.mongodb.options
      end

      Mongoid.observers = Pike::System::Observers::ActivityObserver,
                          Pike::System::Observers::ActivityPropertyValueObserver,
                          Pike::System::Observers::FriendshipObserver,
                          Pike::System::Observers::MessageObserver,
                          Pike::System::Observers::ProjectObserver,
                          Pike::System::Observers::ProjectPropertyValueObserver,
                          Pike::System::Observers::PropertyObserver
      
      Mongoid.instantiate_observers

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
