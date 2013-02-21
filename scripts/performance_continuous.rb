load_script! 'performance'

add_step! (RubyApp::Element::Event) { |event| reset_script!
                                              event.execute {} }
