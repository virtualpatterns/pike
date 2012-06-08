add_step! (RubyApp::Element::Event)                           { |event| event.assert_exists_link('Random') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Random') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('tap to add a task') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }
