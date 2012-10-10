load_script! 'common/logon_random'

# Go to weekly report and verify days
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Weekly Summary') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Weekly Summary') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text(RubyApp::Language.locale.strftime(event.today.week_start + 0, Pike::Application.configuration.format.date.short)) }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text(RubyApp::Language.locale.strftime(event.today.week_start + 01, Pike::Application.configuration.format.date.short)) }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text(RubyApp::Language.locale.strftime(event.today.week_start + 02, Pike::Application.configuration.format.date.short)) }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text(RubyApp::Language.locale.strftime(event.today.week_start + 03, Pike::Application.configuration.format.date.short)) }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text(RubyApp::Language.locale.strftime(event.today.week_start + 04, Pike::Application.configuration.format.date.short)) }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text(RubyApp::Language.locale.strftime(event.today.week_start + 05, Pike::Application.configuration.format.date.short)) }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text(RubyApp::Language.locale.strftime(event.today.week_start + 06, Pike::Application.configuration.format.date.short)) }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Go to weekly report and verify durations and notes
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_work!('Project 01', 'Activity 01', event.today.week_start + 0, 1 * 60 * 60, 'Note 01') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_work!('Project 02', 'Activity 02', event.today.week_start + 1, 2 * 60 * 60, 'Note 02') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_work!('Project 03', 'Activity 03', event.today.week_start + 2, 3 * 60 * 60, 'Note 03') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_work!('Project 04', 'Activity 04', event.today.week_start + 3, 4 * 60 * 60, 'Note 04') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_work!('Project 05', 'Activity 05', event.today.week_start + 4, 5 * 60 * 60, 'Note 05') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_work!('Project 06', 'Activity 06', event.today.week_start + 5, 6 * 60 * 60, 'Note 06') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_work!('Project 07', 'Activity 07', event.today.week_start + 6, 7 * 60 * 60, 'Note 07') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Weekly Summary') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Weekly Summary') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Project 01') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Activity 01') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('1 hr') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Note 01') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Project 02') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Activity 02') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('2 hrs') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Note 02') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Project 03') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Activity 03') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('3 hrs') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Note 03') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Project 04') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Activity 04') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('4 hrs') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Note 04') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Project 05') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Activity 05') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('5 hrs') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Note 05') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Project 06') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Activity 06') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('6 hrs') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Note 06') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Project 07') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Activity 07') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('7 hrs') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Note 07') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Go back to work list
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

load_script! 'common/logoff'
