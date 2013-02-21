load_script! 'performance'

add_step! (RubyApp::Element::Event) { |event| event.execute('window.close();') }
