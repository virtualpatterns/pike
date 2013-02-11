load_script! 'performance'

add_step! (RubyApp::Element::Event) do |event|
  reset_script!
  event.execute {}
end
