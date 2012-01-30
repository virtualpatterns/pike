require 'rubygems'
require 'bundler/setup'

require 'ruby_app/log'

$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), %w[..]))

require 'pike/application'
require 'pike/models'
require 'pike/version'

Pike::Application.create_default!

while true
  Pike::System::Action.where_not_executed.each do |action|
    begin
      action.execute!
    rescue Exception => exception
      RubyApp::Log.exception(exception)
    end
  end
  sleep(15)
end
