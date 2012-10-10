load_script! 'common/logon_random'

# Go to activities
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_text('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activities') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activities') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Activities') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Don't share an activity
# NOTE:  Must do this one BEFORE the next one
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add an activity') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add an activity') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Name') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Name', 'Activity 01') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_input('Shared') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Shared', 'false') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Activity 01') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_not_exists_text('Shared by you') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Share an activity
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add an activity') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add an activity') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Name') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Name', 'Activity 02') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_input('Shared') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Shared', 'true') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('Activity 02') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Shared by you') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Share an activity
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_friendship!("Friend 03 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Activity.create_activity!("Friend 03 of #{Pike::Session.identity.user.id}", 'Activity 03', true, 'Property 03' => 'Value 03') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activities') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activities') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activity 03') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text("Shared by Friend 03 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activity 03') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Property 03') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text("Shared by Friend 03 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Value 03') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.execute {} }

# Delete a shared activity
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_friendship!("Friend 04 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Activity.create_activity!("Friend 04 of #{Pike::Session.identity.user.id}", 'Activity 04', true, 'Property 04' => 'Value 04') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activities') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activities') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activity 04') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activity 04') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_not_exists_link('Delete Activity') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.execute {} }

# Edit a shared activity
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_friendship!("Friend 05.0 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Activity.create_activity!("Friend 05.0 of #{Pike::Session.identity.user.id}", 'Activity 05.0', true, 'Property 05.0' => 'Value 05.0') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Activity.update_activity!("Friend 05.0 of #{Pike::Session.identity.user.id}", 'Activity 05.0', 'Activity 05.1') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activities') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activities') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activity 05.1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text("Shared by Friend 05.0 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activity 05.1') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Property 05.0') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text("Shared by Friend 05.0 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Value 05.0') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.execute {} }

# Delete a shared activity
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_friendship!("Friend 06 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Activity.create_activity!("Friend 06 of #{Pike::Session.identity.user.id}", 'Activity 06', true, 'Property 06' => 'Value 06') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Activity.delete_activity!("Friend 06 of #{Pike::Session.identity.user.id}", 'Activity 06') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activities') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activities') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_not_exists_link('Activity 06') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_not_exists_text("Shared by Friend 3 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Unshare a shared activity
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_friendship!("Friend 07 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Activity.create_activity!("Friend 07 of #{Pike::Session.identity.user.id}", 'Activity 07', true, 'Property 07' => 'Value 07') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Activity.update_activity!("Friend 07 of #{Pike::Session.identity.user.id}", 'Activity 07', nil, false) } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activities') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activities') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_not_exists_link('Activity 07') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_not_exists_text("Shared by Friend 07 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Edit a prooerty of a shared activity
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_friendship!("Friend 08 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Activity.create_activity!("Friend 08 of #{Pike::Session.identity.user.id}", 'Activity 08', true, 'Property 08' => 'Value 08') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activities') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activities') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activity 08') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text("Shared by Friend 08 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activity 08') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_not_exists_link('Property 08') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_not_exists_link('Value 08') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.execute {} }

# Go back to work list
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

load_script! 'common/logoff'
