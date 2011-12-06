puts "Running #{__FILE__.inspect}"

$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), %w[lib]))

require 'pike/application'

Pike::Application.create_default!
