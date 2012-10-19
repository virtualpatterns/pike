add_step! (RubyApp::Element::Event)                           { |event| event.execute {} }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Logon with GitHub') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Logon with GitHub') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('tap to add a task') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Logoff') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Logoff') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Logon with GitHub') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Logon with Google') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Logon with Google') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('tap to add a task') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Logoff') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Logoff') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Logon with Google') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.go('/') }
add_step! (RubyApp::Elements::Mobile::Page::LoadedEvent)      { |event| event.assert_exists_link('Logon with Facebook') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Logon with Facebook') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('tap to add a task') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Logoff') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Logoff') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Logon with Facebook') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }
