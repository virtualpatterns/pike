load_script! 'common/logon_random'

# Go to projects
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_text('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Projects') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Projects') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Projects') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Create a project
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add a project') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add a project') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Name') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Name', 'Project 01') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 01') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Create a blank project
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add a project') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add a project') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Name can\'t be blank.') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('OK') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('OK') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.execute {} }

# Edit a project
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_project!('Project 02.0') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Projects') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Projects') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Project 02.0') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Project 02.0') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Name') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Name', 'Project 02.1') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_not_exists_link('Project 02.0') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Project 02.1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Delete a new project
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add a project') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add a project') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_not_exists_link('Delete Project') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.execute {} }

# Delete a project
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_project!('Project 03') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Projects') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Projects') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Project 03') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Project 03') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Delete Project') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Delete Project') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Are you sure you want to delete this project?') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Yes') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Yes') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_not_exists_link('Project 03') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Don't delete a project
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_project!('Project 05') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Projects') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Projects') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Project 05') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Project 05') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Delete Project') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Delete Project') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Are you sure you want to delete this project?') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('No') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('No') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 05') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Delete a referenced project
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_task!('Project 06', 'Activity 06') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Projects') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Projects') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Project 06') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Project 06') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Delete Project') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Delete Project') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Are you sure you want to delete this project?') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Yes') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Yes') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('The selected project cannot be deleted.  The project is assigned to a task.') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('OK') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('OK') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 06') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Add a property to a new project
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add a project') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add a project') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Name') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Name', 'Project 07') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Save') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Save') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('tap to add a property') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add a property') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Name') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Name', 'Property 07') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_input('Value') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Value', 'Value 07') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Property 07') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Value 07') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 07') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Add a property to a new, blank project
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add a project') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add a project') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Save') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Save') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Name can\'t be blank.') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('OK') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('OK') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.execute {} }

# Add a property to an existing project
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_project!('Project 08') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Projects') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Projects') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Project 08') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Project 08') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('tap to add a property') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add a property') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Name') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Name', 'Property 08') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_input('Value') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Value', 'Value 08') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Property 08') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Value 08') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 08') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Add a blank property to a project
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_project!('Project 09') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Projects') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Projects') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Project 09') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Project 09') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('tap to add a property') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add a property') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Name can\'t be blank.') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('OK') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('OK') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 09') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Edit a property on a project
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_project!('Project 10.0', false, 'Property 10.0' => 'Value 10.0') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Projects') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Projects') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Project 10.0') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Project 10.0') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Property 10.0') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Property 10.0') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Name') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Name', 'Property 10.1') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_input('Value') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Value', 'Value 10.1') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Property 10.1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Value 10.1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 10.0') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Delete a new property from a project
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_project!('Project 11', false, 'Property 11' => 'Value 11') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Projects') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Projects') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Project 11') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Project 11') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.click_link('tap to add a property') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_not_exists_link('Delete Property') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 11') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Delete a property from a project
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_project!('Project 12', false, 'Property 12' => 'Value 12') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Projects') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Projects') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Project 12') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Project 12') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Property 12') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Property 12') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Delete Property') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Delete Property') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Are you sure you want to remove this property?') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Yes') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Yes') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_not_exists_link('Property 12') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_not_exists_link('Value 12') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 12') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Don't delete a property from a project
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_project!('Project 13', false, 'Property 13' => 'Value 13') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Projects') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Projects') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Project 13') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Project 13') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Property 13') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Property 13') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Delete Property') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Delete Property') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Are you sure you want to remove this property?') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('No') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('No') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Property 13') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Value 13') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 13') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Go back to work list
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

load_script! 'common/logoff'
