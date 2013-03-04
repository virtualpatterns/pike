load_script! 'common/logon_random'

# Create a task
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_project!('Project 01') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_activity!('Activity 01') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add a task') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add a task') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('tap to select a project') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to select a project') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Project 01') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Project 01') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('tap to select an activity') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to select an activity') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activity 01') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activity 01') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Other') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Other') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Liked') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Liked') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text('Liked') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Project 01') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Activity 01') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Create a blank task
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add a task') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add a task') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('The following errors were found') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('OK') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('OK') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.execute {} }

# Edit a task
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_task!('Project 02.0', 'Activity 02.0', Pike::Task::FLAG_LIKED) } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_project!('Project  02.1') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_activity!('Activity  02.1') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 02.0') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_list_link('Project 02.0') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Project 02.0') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Project 02.0') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Project  02.1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Project  02.1') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activity 02.0') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activity 02.0') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activity  02.1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activity  02.1') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Liked') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Liked') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Completed') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Completed') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Delete Task') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text('Completed') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Project  02.1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Activity  02.1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Delete a new task
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add a task') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add a task') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_not_exists_link('Delete Task') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.execute {} }

# Delete a task
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_task!('Project 03', 'Activity 03', Pike::Task::FLAG_NORMAL) } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 03') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_list_link('Project 03') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Delete Task') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Delete Task') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Are you sure you want to delete this task?') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Yes') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Yes') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_not_exists_text('Other') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_not_exists_link('Project 03') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_not_exists_link('Activity 03') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Don't delete a task
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_task!('Project 04', 'Activity 04', Pike::Task::FLAG_NORMAL) } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 04') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_list_link('Project 04') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Delete Task') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Delete Task') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Are you sure you want to delete this task?') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('No') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('No') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text('Other') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Project 04') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Activity 04') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Add a property to a new task
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_project!('Project 05') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_activity!('Activity 05') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add a task') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add a task') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('tap to select a project') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to select a project') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Project 05') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Project 05') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('tap to select an activity') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to select an activity') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activity 05') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activity 05') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Other') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Other') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Liked') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Liked') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Save') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Save') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('tap to add a property') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add a property') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Name') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Name', 'Property 05') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_input('Value') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Value', 'Value 05') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Property 05') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Value 05') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 05') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Activity 05') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Add a property to a new, blank task
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add a task') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add a task') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Save') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Save') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('The following errors were found') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('OK') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('OK') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.execute {} }

# Add a property to an existing task
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_task!('Project 06', 'Activity 06', Pike::Task::FLAG_LIKED) } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 06') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_list_link('Project 06') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('tap to add a property') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add a property') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Name') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Name', 'Property 06') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_input('Value') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Value', 'Value 06') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Property 06') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Value 06') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 06') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Activity 06') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Add a blank property to a task
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_task!('Project 07', 'Activity 07', Pike::Task::FLAG_LIKED) } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 07') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_list_link('Project 07') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('tap to add a property') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add a property') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('The following errors were found') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('OK') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('OK') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 07') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Activity 07') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Edit a property on a task
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_task!('Project 08.0', 'Activity 08.0', Pike::Task::FLAG_LIKED, 'Property 08.0' => 'Value 08.0') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 08.0') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_list_link('Project 08.0') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Property 08.0') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Property 08.0') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Name') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Name', 'Property 08.1') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_input('Value') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Value', 'Value 08.1') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Property 08.1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Value 08.1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 08.0') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Activity 08.0') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Delete a new property from a task
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_task!('Project 09', 'Activity 09', Pike::Task::FLAG_LIKED) } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 09') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_list_link('Project 09') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('tap to add a property') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add a property') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_not_exists_link('Delete Property') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 09') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Activity 09') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Delete a property from a task
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_task!('Project 10', 'Activity 10', Pike::Task::FLAG_LIKED, 'Property 10' => 'Value 10') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 10') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_list_link('Project 10') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Property 10') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Property 10') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Delete Property') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Delete Property') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Are you sure you want to remove this property?') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Yes') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Yes') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_not_exists_link('Property 10') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_not_exists_link('Value 10') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 10') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Activity 10') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Don't delete a property from a task
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_task!('Project 11', 'Activity 11', Pike::Task::FLAG_LIKED, 'Property 11' => 'Value 11') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 11') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_list_link('Project 11') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Property 11') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Property 11') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Delete Property') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Delete Property') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Are you sure you want to remove this property?') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('No') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('No') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Property 11') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Value 11') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 11') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Activity 11') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

load_script! 'common/logoff'
