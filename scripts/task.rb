load_script! 'common/logon_random'

# Create a task
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_project!('Project 1') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_activity!('Activity 1') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add a task') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('tap to add a task') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('tap to select a project') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('tap to select a project') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Project 1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Project 1') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('tap to select an activity') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('tap to select an activity') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activity 1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Activity 1') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Other') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Other') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Liked') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Liked') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.tap_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text('Liked') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Project 1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Activity 1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Edit a task
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_task!('Project 2', 'Activity 2', Pike::Task::FLAG_LIKED) } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_project!('Project 3') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_activity!('Activity 3') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 2') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_list_link('Project 2') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Project 2') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Project 2') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Project 3') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Project 3') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activity 2') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Activity 2') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activity 3') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Activity 3') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Liked') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Liked') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Completed') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Completed') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.tap_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text('Completed') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Project 3') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Activity 3') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Delete a task
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_task!('Project 4', 'Activity 4', Pike::Task::FLAG_NORMAL) } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 4') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_list_link('Project 4') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Delete Task') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Delete Task') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Are you sure you want to delete this task?') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Yes') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Yes') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_not_exists_text('Other') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_not_exists_text('Project 4') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_not_exists_text('Activity 4') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Don't delete a task
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_task!('Project 5', 'Activity 5', Pike::Task::FLAG_NORMAL) } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 5') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_list_link('Project 5') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Delete Task') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Delete Task') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Are you sure you want to delete this task?') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('No') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('No') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text('Other') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Project 5') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Activity 5') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Add a property to a task
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_task!('Project 6', 'Activity 6', Pike::Task::FLAG_LIKED) } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 6') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_list_link('Project 6') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('tap to add a property') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('tap to add a property') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Name') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Name', 'Property 1') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_input('Value') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Value', 'Value 1') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text('Property 1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Value 1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text('Project 6') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Activity 6') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Edit a property on a task
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_task!('Project 7', 'Activity 7', Pike::Task::FLAG_LIKED, 'Property 2' => 'Value 2') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 7') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_list_link('Project 7') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Property 2') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Property 2') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Value') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Value', 'Value 3') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text('Property 2') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Value 3') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text('Project 7') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Activity 7') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Delete a property from a task
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_task!('Project 8', 'Activity 8', Pike::Task::FLAG_LIKED, 'Property 3_1' => 'Value 3.1') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 8') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_list_link('Project 8') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Property 3_1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Property 3_1') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Remove Property') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Remove Property') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Are you sure you want to remove this property?') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Yes') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Yes') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_not_exists_text('Property 3_1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_not_exists_text('Value 3.1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text('Project 8') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Activity 8') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Don't delete a property from a task
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_task!('Project 9', 'Activity 9', Pike::Task::FLAG_LIKED, 'Property 3_2' => 'Value 3.2') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 9') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_list_link('Project 9') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Property 3_2') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Property 3_2') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Remove Property') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Remove Property') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Are you sure you want to remove this property?') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('No') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('No') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text('Property 3_2') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Value 3.2') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text('Project 9') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Activity 9') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

load_script! 'common/logoff'
