add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Logoff') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Logoff') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Logon with Google') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }
