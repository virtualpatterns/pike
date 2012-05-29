load_script! 'common/logon_random'

add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_text('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('About') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('About') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('About') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('tap to add a task') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

load_script! 'common/logoff'
