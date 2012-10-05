load_script! 'common/logon_random'

# Go to projects
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_text('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Projects') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Projects') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Projects') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Confirm a shared project property
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Project.create_shared_project!("Friend 1 of #{Pike::Session.identity.user.id}", Pike::Session.identity.user.url, 'Project 1', 'Property 1' => 'Value 1') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add a project') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add a project') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Name') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Name', 'Project 1') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Save') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Save') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text('Property 1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text('Project 1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Confirm a shared project property cannot be deleted
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Project.create_shared_project!("Friend 2 of #{Pike::Session.identity.user.id}", Pike::Session.identity.user.url, 'Project 2', 'Property 2' => 'Value 2') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add a project') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add a project') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Name') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Name', 'Project 2') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Save') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Save') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Property 2') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Property 2') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_not_exists_link('Remove Property') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text('Project 2') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Go back to work list
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('tap to add a task') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Go to activities
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_text('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activities') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activities') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Activities') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Confirm a shared activity property
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Activity.create_shared_activity!("Friend 1 of #{Pike::Session.identity.user.id}", Pike::Session.identity.user.url, 'Activity 1', 'Property 1' => 'Value 1') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add an activity') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add an activity') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Name') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Name', 'Activity 1') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Save') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Save') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text('Property 1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text('Activity 1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Confirm a shared activity property cannot be deleted
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Activity.create_shared_activity!("Friend 2 of #{Pike::Session.identity.user.id}", Pike::Session.identity.user.url, 'Activity 2', 'Property 2' => 'Value 2') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add an activity') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add an activity') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Name') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Name', 'Activity 2') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Save') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Save') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Property 2') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Property 2') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_not_exists_link('Remove Property') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text('Activity 2') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Go back to work list
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('tap to add a task') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

load_script! 'common/logoff'
