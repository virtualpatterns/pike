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
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Name', 'Activity 1') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_input('Shared') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Shared', 'false') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text('Activity 1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_not_exists_text('Shared by you') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Share an activity
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add an activity') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add an activity') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Name') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Name', 'Activity 2') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_input('Shared') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Shared', 'true') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text('Activity 2') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Shared by you') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Confirm a shared activity
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Activity.create_shared_activity!("Friend 1.1 of #{Pike::Session.identity.user.id}", Pike::Session.identity.user.url, 'Activity 3.1') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activities') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activities') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Activity 3.1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text("Shared by Friend 1.1 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Confirm a shared activity cannot be deleted
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Activity.create_shared_activity!("Friend 1.2 of #{Pike::Session.identity.user.id}", Pike::Session.identity.user.url, 'Activity 3.2') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activities') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activities') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activity 3.2') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activity 3.2') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_not_exists_link('Delete Activity') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.execute {} }

# Confirm an edited shared activity
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Activity.create_shared_activity!("Friend 2 of #{Pike::Session.identity.user.id}", Pike::Session.identity.user.url, 'Activity 4') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Activity.update_shared_activity!("Friend 2 of #{Pike::Session.identity.user.id}", 'Activity 4', 'Activity 5') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activities') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activities') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Activity 5') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text("Shared by Friend 2 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Confirm a deleted shared activity
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Activity.create_shared_activity!("Friend 3 of #{Pike::Session.identity.user.id}", Pike::Session.identity.user.url, 'Activity 6') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Activity.delete_shared_activity!("Friend 3 of #{Pike::Session.identity.user.id}", 'Activity 6') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activities') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activities') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_not_exists_text('Activity 6') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_not_exists_text("Shared by Friend 3 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Confirm a no longer shared activity
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Activity.create_shared_activity!("Friend 4 of #{Pike::Session.identity.user.id}", Pike::Session.identity.user.url, 'Activity 7') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Activity.unshare_activity!("Friend 4 of #{Pike::Session.identity.user.id}", 'Activity 7') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Activities') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Activities') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_not_exists_text('Activity 7') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_not_exists_text("Shared by Friend 4 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Go back to work list
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('tap to add a task') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

load_script! 'common/logoff'
