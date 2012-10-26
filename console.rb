require 'rubygems'
require 'bundler/setup'

require 'ap'

require 'ruby_app'

$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), %w[lib]))

require 'pike'

puts "Running #{__FILE__.inspect}"

RubyApp::Configuration.load!([ File.join(RubyApp::ROOT, %w[configuration.yml]),
                               File.join(Pike::ROOT, %w[configuration.yml])])
RubyApp::Log.open!
RubyApp::Application.create!

at_exit do
  RubyApp::Application.destroy!
  RubyApp::Log.close!
  RubyApp::Configuration.unload!
end
