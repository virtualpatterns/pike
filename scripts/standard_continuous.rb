load_script! 'standard_no_logon'

add_step! (RubyApp::Element::Event) do |event|
  reset_script!
  event.execute {}
end
