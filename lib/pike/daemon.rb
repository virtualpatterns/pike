require 'rubygems'
require 'bundler/setup'

require 'ruby_app'

$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), %w[..]))

require 'pike'
require 'pike/models'

RubyApp::Configuration.load!([ File.join(RubyApp::ROOT, %w[configuration.yml]),
                               File.join(Pike::ROOT, %w[configuration.yml])])
RubyApp::Log.open!
RubyApp::Application.create!

at_exit do
  RubyApp::Application.destroy!
  RubyApp::Log.close!
  RubyApp::Configuration.unload!
end

while true
  Pike::System::Action.where_not_executed.each do |action|
    RubyApp::Request.create_context! do
      begin
        action.execute!
      rescue => exception
        RubyApp::Log.exception(RubyApp::Log::ERROR, exception)
      end
    end
  end
  sleep(15)
end
