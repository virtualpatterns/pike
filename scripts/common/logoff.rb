add_step! (RubyApp::Element::Event)                           { |event| event.assert_exists_link('Logoff') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Logoff') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Logon with Google') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }
