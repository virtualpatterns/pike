require 'rubygems'
require 'bundler/setup'

require 'ruby_app'

module Pike

  class Session < RubyApp::Session

    def initialize
      require 'pike/elements/document'
      super(Pike::Elements::Document.new)
    end

  end

end
