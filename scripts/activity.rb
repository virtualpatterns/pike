load_script! 'common/logon_random'

# Go to activities
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_text('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activities') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activities') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Activities') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Create an activity
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add an activity') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add an activity') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Name') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Name', 'Activity 01') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Activity 01') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Create a blank activity
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add an activity') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add an activity') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('The following errors were found') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('OK') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('OK') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.execute {} }

# Edit an activity
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_activity!('Activity 02.0') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activities') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activities') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activity 02.0') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activity 02.0') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Name') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Name', 'Activity 02.1') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_not_exists_link('Activity 02.0') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Activity 02.1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Delete a new activity
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add an activity') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add an activity') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_not_exists_link('Delete Activity') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.execute {} }

# Delete an activity
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_activity!('Activity 03') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activities') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activities') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activity 03') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activity 03') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Delete Activity') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Delete Activity') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Are you sure you want to delete this activity?') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Yes') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Yes') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_not_exists_link('Activity 03') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Don't delete an activity
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_activity!('Activity 05') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activities') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activities') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activity 05') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activity 05') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Delete Activity') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Delete Activity') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Are you sure you want to delete this activity?') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('No') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('No') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Activity 05') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Delete a referenced activity
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_task!('Activity 06', 'Activity 06') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activities') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activities') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activity 06') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activity 06') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Delete Activity') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Delete Activity') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Are you sure you want to delete this activity?') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Yes') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Yes') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('The selected activity cannot be deleted.  The activity is assigned to a task.') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('OK') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('OK') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Activity 06') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Add a property to a new activity
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add an activity') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add an activity') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Name') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Name', 'Activity 07') }
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
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Activity 07') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Add a property to a new, blank activity
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add an activity') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add an activity') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Save') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Save') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('The following errors were found') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('OK') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('OK') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.execute {} }

# Add a property to an existing activity
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_activity!('Activity 08') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activities') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activities') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activity 08') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activity 08') }
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
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Activity 08') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Add a blank property to an activity
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_activity!('Activity 09') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activities') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activities') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activity 09') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activity 09') }
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
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Activity 09') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Edit a property on an activity
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_activity!('Activity 10.0', false, 'Property 10.0' => 'Value 10.0') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activities') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activities') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activity 10.0') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activity 10.0') }
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
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Activity 10.0') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Delete a new property from an activity
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_activity!('Activity 11', false, 'Property 11' => 'Value 11') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activities') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activities') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activity 11') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activity 11') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.click_link('tap to add a property') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_not_exists_link('Delete Property') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Activity 11') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Delete a property from an activity
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_activity!('Activity 12', false, 'Property 12' => 'Value 12') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activities') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activities') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activity 12') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activity 12') }
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
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Activity 12') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Don't delete a property from an activity
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_activity!('Activity 13', false, 'Property 13' => 'Value 13') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activities') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activities') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activity 13') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activity 13') }
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
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Activity 13') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Go back to work list
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

load_script! 'common/logoff'
