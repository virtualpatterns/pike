load_script! 'common/logon_random'

# Go to weekly report
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_work!('Project 1', 'Activity 1', Date.today, 1 * 60 * 60) } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_work!('Project 2', 'Activity 2', Date.today, 2 * 60 * 60) } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_work!('Project 3', 'Activity 3', Date.today, 3 * 60 * 60) } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Weekly Summary') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Weekly Summary') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Project 1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Activity 1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('1 hr') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Project 2') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Activity 2') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('2 hrs') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Project 3') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Activity 3') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('3 hrs') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Go back to work list
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('tap to add a task') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

load_script! 'common/logoff'
