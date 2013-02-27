load_script! 'common/logon_random'

add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('About') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('About') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('About') }

add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('System Information') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('System Information') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Information') }

add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

load_script! 'common/logoff'
