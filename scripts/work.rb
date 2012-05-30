load_script! 'common/logon_random'

# Start and stop a task
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_task!('Project 1', 'Activity 1', Pike::Task::FLAG_LIKED) } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_list_item('Project 1') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert('Pike::Session.identity.user.work.where_started.count == 1') { Pike::Session.identity.user.work.where_started.count == 1 } }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Project 1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_list_item('Project 1') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert('Pike::Session.identity.user.work.where_started.count == 0') { Pike::Session.identity.user.work.where_started.count == 0 } }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Edit the duration of a task
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_task!('Project 2', 'Activity 2', Pike::Task::FLAG_LIKED) } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 2') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_list_link('Project 2') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Duration') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Duration', '2.5h') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text('Project 2') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Activity 2') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('2 hrs 30 mins') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Edit the duration of a started task
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_task!('Project 3', 'Activity 3', Pike::Task::FLAG_LIKED) } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 3') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_list_item('Project 3') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.tap_list_link('Project 3') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Duration') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Duration', '2.5h') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text('Project 3') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Activity 3') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('2 hrs 30 mins') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Project 3') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_list_item('Project 3') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.execute {} }

# Change the date
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_task!('Project 4', 'Activity 4', Pike::Task::FLAG_LIKED) } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text(RubyApp::Language.locale.strftime(event.today, Pike::Application.configuration.format.date.short)) }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.swipe(:left) }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link(RubyApp::Language.locale.strftime(event.today << 1, '%b')) }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link(RubyApp::Language.locale.strftime(event.today << 1, '%b')) }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link((event.today << 1).day) }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link((event.today << 1).day) }
add_step! (RubyApp::Element::UpdatedEvent)
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text(RubyApp::Language.locale.strftime(event.today << 1, Pike::Application.configuration.format.date.short)) }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.swipe(:left) }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Today') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Today') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text(RubyApp::Language.locale.strftime(event.today, Pike::Application.configuration.format.date.short)) }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Starting or stopping a task for a day other than today edits the duration of the task
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_task!('Project 5', 'Activity 5', Pike::Task::FLAG_LIKED) } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text(RubyApp::Language.locale.strftime(event.today, Pike::Application.configuration.format.date.short)) }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.swipe(:left) }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link(RubyApp::Language.locale.strftime(event.today << 1, '%b')) }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link(RubyApp::Language.locale.strftime(event.today << 1, '%b')) }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link((event.today << 1).day) }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link((event.today << 1).day) }
add_step! (RubyApp::Element::UpdatedEvent)
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text(RubyApp::Language.locale.strftime(event.today << 1, Pike::Application.configuration.format.date.short)) }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Project 5') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_list_item('Project 5') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text('Project 5') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Activity 5') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.swipe(:left) }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Today') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Today') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text(RubyApp::Language.locale.strftime(event.today, Pike::Application.configuration.format.date.short)) }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

load_script! 'common/logoff'
