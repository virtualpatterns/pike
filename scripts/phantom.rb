load_script! 'standard'

add_step! (RubyApp::Element::Event) { |event| event.execute('window.close();') }
