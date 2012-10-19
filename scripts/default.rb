add_step! (RubyApp::Element::Event)                           { |event| event.execute {} }

add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Scripts') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Scripts') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Scripts') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Scripts') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('First') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('First') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('tap to add a task') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Logoff') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Logoff') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('First') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Second') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Second') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('tap to add a task') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Logoff') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Logoff') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Second') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Random') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Random') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('tap to add a task') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Logoff') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Logoff') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Random') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }
