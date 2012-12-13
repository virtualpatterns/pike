load_script! 'all_once'

add_step! (RubyApp::Element::Event) { |event| event.execute('window.close();') }
