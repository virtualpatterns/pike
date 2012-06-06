load_script! 'common/logon_random'

# Go to projects
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_text('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Projects') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Projects') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Projects') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Don't share a project
# NOTE:  Must do this one BEFORE the next one
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add a project') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('tap to add a project') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Name') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Name', 'Project 1') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_input('Shared') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Shared', 'false') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text('Project 1') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_not_exists_text('Shared by you') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Share a project
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add a project') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('tap to add a project') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Name') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Name', 'Project 2') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_input('Shared') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Shared', 'true') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text('Project 2') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Shared by you') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Confirm a shared project
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Project.create_shared_project!("Friend 1 of #{Pike::Session.identity.user.id}", Pike::Session.identity.user.url, 'Project 3') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Projects') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Projects') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Project 3') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text("Shared by Friend 1 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Confirm an edited shared project
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Project.create_shared_project!("Friend 2 of #{Pike::Session.identity.user.id}", Pike::Session.identity.user.url, 'Project 4') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Project.update_shared_project!("Friend 2 of #{Pike::Session.identity.user.id}", 'Project 4', 'Project 5') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Projects') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Projects') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Project 5') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text("Shared by Friend 2 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Confirm a deleted shared project
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Project.create_shared_project!("Friend 3 of #{Pike::Session.identity.user.id}", Pike::Session.identity.user.url, 'Project 6') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Project.delete_shared_project!("Friend 3 of #{Pike::Session.identity.user.id}", 'Project 6') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Projects') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Projects') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_not_exists_text('Project 6') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_not_exists_text("Shared by Friend 3 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Confirm a no longer shared project
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Project.create_shared_project!("Friend 4 of #{Pike::Session.identity.user.id}", Pike::Session.identity.user.url, 'Project 7') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Project.unshare_project!("Friend 4 of #{Pike::Session.identity.user.id}", 'Project 7') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::System::Action.execute_all! } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Projects') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Projects') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_not_exists_text('Project 7') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_not_exists_text("Shared by Friend 4 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Go back to work list
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('tap to add a task') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

load_script! 'common/logoff'
