load_script! 'common/logon_random'

# Start and stop a task
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_task!('Project 01', 'Activity 01', Pike::Task::FLAG_LIKED) } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 01') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_list_item('Project 01') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert('Pike::Session.identity.user.work.where_started.count == 01') { Pike::Session.identity.user.work.where_started.count == 01 } }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Project 01') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_list_item('Project 01') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert('Pike::Session.identity.user.work.where_started.count == 0') { Pike::Session.identity.user.work.where_started.count == 0 } }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Edit the duration of a task
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_task!('Project 02', 'Activity 02', Pike::Task::FLAG_LIKED) } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 02') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_list_link('Project 02') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Duration') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Duration', '2.5h') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 02') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Activity 02') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('2 hrs 30 mins') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Total: 2 hrs 30 mins') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Edit the note of a task
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_task!('Project 03', 'Activity 03', Pike::Task::FLAG_LIKED) } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 03') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_list_link('Project 03') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Note') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Note', 'Note 03') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 03') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_list_link('Project 03') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Note', 'Note 03') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.execute {} }

# Edit the duration of a started task
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_task!('Project 04', 'Activity 04', Pike::Task::FLAG_LIKED) } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 04') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_list_item('Project 04') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.click_list_link('Project 04') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Duration') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Duration', '2.5h') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 04') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Activity 04') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('2 hrs 30 mins') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Total: 5 hrs') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Project 04') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_list_item('Project 04') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.execute {} }

# Delete a started task
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_task!('Project 05', 'Activity 05', Pike::Task::FLAG_LIKED) } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 05') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_list_item('Project 05') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.click_list_link('Project 05') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Delete Task') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Delete Task') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Are you sure you want to delete this task?') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Yes') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Yes') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_not_exists_text('Other') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_not_exists_link('Project 05') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_not_exists_link('Activity 05') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Change the date
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_task!('Project 06', 'Activity 06', Pike::Task::FLAG_LIKED) } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text(RubyApp::Language.locale.strftime(event.today, Pike::Application.configuration.format.date.short)) }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.swipe(:left) }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link(RubyApp::Language.locale.strftime(event.today << 1, '%b')) }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link(RubyApp::Language.locale.strftime(event.today << 1, '%b')) }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('15') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('15') }
add_step! (RubyApp::Element::UpdatedEvent)
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text(RubyApp::Language.locale.strftime(event.today << 1, '%b 15')) }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.swipe(:left) }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Today') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Today') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text(RubyApp::Language.locale.strftime(event.today, Pike::Application.configuration.format.date.short)) }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Starting or stopping a task for a day other than today edits the duration of the task
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_task!('Project 07', 'Activity 07', Pike::Task::FLAG_LIKED) } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text(RubyApp::Language.locale.strftime(event.today, Pike::Application.configuration.format.date.short)) }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.swipe(:left) }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link(RubyApp::Language.locale.strftime(event.today << 1, '%b')) }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link(RubyApp::Language.locale.strftime(event.today << 1, '%b')) }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('15') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('15') }
add_step! (RubyApp::Element::UpdatedEvent)
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text(RubyApp::Language.locale.strftime(event.today << 1, '%b 15')) }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Project 07') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_list_item('Project 07') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 07') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Activity 07') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.swipe(:left) }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Today') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Today') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text(RubyApp::Language.locale.strftime(event.today, Pike::Application.configuration.format.date.short)) }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

load_script! 'common/logoff'
