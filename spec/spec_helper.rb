$PIKE_ROOT = File.expand_path(File.join(File.dirname(__FILE__), %w[.. ..]))
$LOAD_PATH.unshift $PIKE_ROOT unless $LOAD_PATH.include?($PIKE_ROOT)

require 'spec/support/shared'

RSpec.configure do |configuration|
  require 'mongoid-rspec'
  configuration.include Mongoid::Matchers
end
