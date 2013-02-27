load_script! 'common/logon_random'

# Go to projects
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_text('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Projects') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Projects') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Projects') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Share a project property
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::User.create_user!("Friend 01 of #{Pike::Session.identity.user.id}", "Friend 01 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_friendship!("Friend 01 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Property.create_property!("Friend 01 of #{Pike::Session.identity.user.id}", Pike::Property::TYPE_PROJECT, 'Property 01') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add a project') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add a project') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Name') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Name', 'Project 01') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Save') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Save') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Property 01') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Property 01') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 01') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Edit a shared project property
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::User.create_user!("Friend 02.0 of #{Pike::Session.identity.user.id}", "Friend 02.0 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_friendship!("Friend 02.0 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Property.create_property!("Friend 02.0 of #{Pike::Session.identity.user.id}", Pike::Property::TYPE_PROJECT, 'Property 02.0') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Property.update_property!("Friend 02.0 of #{Pike::Session.identity.user.id}", Pike::Property::TYPE_PROJECT, 'Property 02.0', 'Property 02.1') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add a project') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add a project') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Name') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Name', 'Project 02.0') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Save') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Save') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Property 02.1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 02.0') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Delete a shared project property
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::User.create_user!("Friend 03.1 of #{Pike::Session.identity.user.id}", "Friend 03.1 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_friendship!("Friend 03.1 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Property.create_property!("Friend 03.1 of #{Pike::Session.identity.user.id}", Pike::Property::TYPE_PROJECT, 'Property 03.1') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add a project') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add a project') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Name') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Name', 'Project 03.1') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Save') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Save') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Property 03.1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Property 03.1') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_not_exists_link('Delete Property') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 03.1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Delete a shared project property
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::User.create_user!("Friend 03.2 of #{Pike::Session.identity.user.id}", "Friend 03.2 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_friendship!("Friend 03.2 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Property.create_property!("Friend 03.2 of #{Pike::Session.identity.user.id}", Pike::Property::TYPE_PROJECT, 'Property 03.2') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Property.delete_property!("Friend 03.2 of #{Pike::Session.identity.user.id}", Pike::Property::TYPE_PROJECT, 'Property 03.2') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add a project') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add a project') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Name') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Name', 'Project 03.2') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Save') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Save') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_not_exists_link('Property 03.2') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 03.2') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Delete a friendship, unshare a shared project property
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::User.create_user!("Friend 03.3 of #{Pike::Session.identity.user.id}", "Friend 03.3 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_friendship!("Friend 03.3 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Property.create_property!("Friend 03.3 of #{Pike::Session.identity.user.id}", Pike::Property::TYPE_PROJECT, 'Property 03.3') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.delete_friendship!("Friend 03.3 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add a project') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add a project') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Name') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Name', 'Project 03.3') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Save') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Save') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_not_exists_link('Property 03.3') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Project 03.3') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Go back to work list
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Go to activities
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_text('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activities') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activities') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Activities') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Share an activity property
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::User.create_user!("Friend 04 of #{Pike::Session.identity.user.id}", "Friend 04 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_friendship!("Friend 04 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Property.create_property!("Friend 04 of #{Pike::Session.identity.user.id}", Pike::Property::TYPE_ACTIVITY, 'Property 04') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add an activity') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add an activity') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Name') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Name', 'Activity 04') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Save') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Save') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Property 04') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Property 04') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Activity 04') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Edit a shared activity property
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::User.create_user!("Friend 05.0 of #{Pike::Session.identity.user.id}", "Friend 05.0 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_friendship!("Friend 05.0 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Property.create_property!("Friend 05.0 of #{Pike::Session.identity.user.id}", Pike::Property::TYPE_ACTIVITY, 'Property 05.0') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Property.update_property!("Friend 05.0 of #{Pike::Session.identity.user.id}", Pike::Property::TYPE_ACTIVITY, 'Property 05.0', 'Property 05.1') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add an activity') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add an activity') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Name') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Name', 'Activity 05.0') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Save') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Save') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Property 05.1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Activity 05.0') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Delete a shared activity property
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::User.create_user!("Friend 06.1 of #{Pike::Session.identity.user.id}", "Friend 06.1 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_friendship!("Friend 06.1 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Property.create_property!("Friend 06.1 of #{Pike::Session.identity.user.id}", Pike::Property::TYPE_ACTIVITY, 'Property 06.1') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add an activity') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add an activity') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Name') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Name', 'Activity 06.1') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Save') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Save') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Property 06.1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Property 06.1') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_not_exists_link('Delete Property') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Activity 06.1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Delete a shared activity property
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::User.create_user!("Friend 06.2 of #{Pike::Session.identity.user.id}", "Friend 06.2 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_friendship!("Friend 06.2 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Property.create_property!("Friend 06.2 of #{Pike::Session.identity.user.id}", Pike::Property::TYPE_ACTIVITY, 'Property 06.2') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Property.delete_property!("Friend 06.2 of #{Pike::Session.identity.user.id}", Pike::Property::TYPE_ACTIVITY, 'Property 06.2') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add an activity') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add an activity') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Name') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Name', 'Activity 06.2') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Save') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Save') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_not_exists_link('Property 06.2') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Activity 06.2') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Delete a friendship, unshare a shared activity property
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::User.create_user!("Friend 03.3 of #{Pike::Session.identity.user.id}", "Friend 03.3 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_friendship!("Friend 03.3 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Property.create_property!("Friend 03.3 of #{Pike::Session.identity.user.id}", Pike::Property::TYPE_ACTIVITY, 'Property 03.3') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.delete_friendship!("Friend 03.3 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add an activity') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add an activity') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Name') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Name', 'Activity 03.3') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Save') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Save') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_not_exists_link('Property 03.3') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Activity 03.3') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Go back to work list
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Share a task property
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::User.create_user!("Friend 07 of #{Pike::Session.identity.user.id}", "Friend 07 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_friendship!("Friend 07 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Property.create_property!("Friend 07 of #{Pike::Session.identity.user.id}", Pike::Property::TYPE_TASK, 'Property 07') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_project!("Project 07") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_activity!("Activity 07") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add a task') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add a task') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('tap to select a project') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to select a project') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Project 07') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Project 07') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('tap to select an activity') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to select an activity') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activity 07') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activity 07') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Other') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Other') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Liked') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Liked') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Save') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Save') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Property 07') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Property 07') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.execute {} }

# Edit a shared task property
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::User.create_user!("Friend 08.0 of #{Pike::Session.identity.user.id}", "Friend 08.0 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_friendship!("Friend 08.0 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Property.create_property!("Friend 08.0 of #{Pike::Session.identity.user.id}", Pike::Property::TYPE_TASK, 'Property 08.0') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Property.update_property!("Friend 08.0 of #{Pike::Session.identity.user.id}", Pike::Property::TYPE_TASK, 'Property 08.0', 'Property 08.1') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_project!("Project 08.0") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_activity!("Activity 08.0") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add a task') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add a task') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('tap to select a project') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to select a project') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Project 08.0') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Project 08.0') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('tap to select an activity') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to select an activity') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activity 08.0') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activity 08.0') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Other') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Other') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Liked') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Liked') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Save') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Save') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Property 08.1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.execute {} }

# Delete a shared task property
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::User.create_user!("Friend 09.1 of #{Pike::Session.identity.user.id}", "Friend 09.1 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_friendship!("Friend 09.1 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Property.create_property!("Friend 09.1 of #{Pike::Session.identity.user.id}", Pike::Property::TYPE_TASK, 'Property 09.1') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_project!("Project 09.1") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_activity!("Activity 09.1") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add a task') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add a task') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('tap to select a project') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to select a project') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Project 09.1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Project 09.1') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('tap to select an activity') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to select an activity') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activity 09.1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activity 09.1') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Other') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Other') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Liked') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Liked') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Save') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Save') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Property 09.1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Property 09.1') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_not_exists_link('Delete Property') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.execute {} }

# Delete a shared task property
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::User.create_user!("Friend 09.2 of #{Pike::Session.identity.user.id}", "Friend 09.2 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_friendship!("Friend 09.2 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Property.create_property!("Friend 09.2 of #{Pike::Session.identity.user.id}", Pike::Property::TYPE_TASK, 'Property 09.2') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Property.delete_property!("Friend 09.2 of #{Pike::Session.identity.user.id}", Pike::Property::TYPE_TASK, 'Property 09.2') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_project!("Project 09.2") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_activity!("Activity 09.2") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add a task') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add a task') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('tap to select a project') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to select a project') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Project 09.2') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Project 09.2') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('tap to select an activity') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to select an activity') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activity 09.2') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activity 09.2') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Other') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Other') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Liked') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Liked') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Save') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Save') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_not_exists_link('Property 09.2') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.execute {} }

# Delete a friendship, unshare a shared task property
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::User.create_user!("Friend 03.3 of #{Pike::Session.identity.user.id}", "Friend 03.3 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_friendship!("Friend 03.3 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Property.create_property!("Friend 03.3 of #{Pike::Session.identity.user.id}", Pike::Property::TYPE_TASK, 'Property 03.3') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.delete_friendship!("Friend 03.3 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_project!("Project 09.3") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_activity!("Activity 09.3") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add a task') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add a task') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('tap to select a project') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to select a project') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Project 09.3') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Project 09.3') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('tap to select an activity') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to select an activity') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activity 09.3') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activity 09.3') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Other') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Other') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Liked') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Liked') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Save') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Save') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_not_exists_link('Property 03.3') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.execute {} }

load_script! 'common/logoff'
