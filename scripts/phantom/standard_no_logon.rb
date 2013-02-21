load_script! 'standard_no_logon'

add_step! (RubyApp::Element::Event) { |event| event.execute('window.close();') }
