load_script! 'common/logon_random'

# View a message
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { sleep(1) } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Message.create_message!('Message Subject 01', 'Message Body 01') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('tap to read new messages') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to read new messages') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Message Subject 01') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Message Subject 01') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Message Subject 01') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Message Body 01') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_not_exists_link('tap to read new messages') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('tap to add a task') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Clear messages
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { sleep(1) } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Message.create_message!('Message Subject 02.1', 'Message Body 02.1') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Message.create_message!('Message Subject 02.2', 'Message Body 02.1') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Message.create_message!('Message Subject 02.3', 'Message Body 02.3') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('tap to read new messages') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to read new messages') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Clear') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Clear') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_not_exists_link('tap to read new messages') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('tap to add a task') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

load_script! 'common/logoff'
