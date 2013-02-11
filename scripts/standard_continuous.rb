load_script! 'all_once'

add_step! (RubyApp::Element::Event) do |event|
  reset_script!
  event.execute {}
end
