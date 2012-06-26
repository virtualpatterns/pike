load_script! 'common/logon_random'

# Go to weekly report
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_work!('Project 1', 'Activity 1', event.today.week_start + 0, 1 * 60 * 60) } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_work!('Project 2', 'Activity 2', event.today.week_start + 1, 2 * 60 * 60) } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_work!('Project 3', 'Activity 3', event.today.week_start + 2, 3 * 60 * 60) } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_work!('Project 4', 'Activity 4', event.today.week_start + 3, 4 * 60 * 60) } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_work!('Project 5', 'Activity 5', event.today.week_start + 4, 5 * 60 * 60) } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_work!('Project 6', 'Activity 6', event.today.week_start + 5, 6 * 60 * 60) } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_work!('Project 7', 'Activity 7', event.today.week_start + 6, 7 * 60 * 60) } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Weekly Summary') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Weekly Summary') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Project 1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Activity 1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('1 hr') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Project 2') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Activity 2') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('2 hrs') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Project 3') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Activity 3') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('3 hrs') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Project 4') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Activity 4') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('4 hrs') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Project 5') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Activity 5') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('5 hrs') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Project 6') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Activity 6') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('6 hrs') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Project 7') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Activity 7') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('7 hrs') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Go back to work list
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('tap to add a task') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

load_script! 'common/logoff'
