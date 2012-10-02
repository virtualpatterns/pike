load_script! 'common/logon_random'

# Go to more ...
add_step! (RubyApp::Element::ExecutedEvent)                                 { |event| event.assert_exists_text('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                                 { |event| event.click_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)                     { |event| event.assert_exists_text('More') }
add_step! (RubyApp::Element::AssertedEvent)                                 { |event| event.execute {} }

# Change a user to an administrator
add_step! (RubyApp::Element::ExecutedEvent)                                 { |event| event.execute { Pike::User.create_user!("User 1 of #{Pike::Session.identity.user.id}", false) } }
add_step! (RubyApp::Element::ExecutedEvent)                                 { |event| event.assert_exists_link('Manage Users') }
add_step! (RubyApp::Element::AssertedEvent)                                 { |event| event.click_link('Manage Users') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)                     { |event| event.assert_exists_input('User') }
add_step! (RubyApp::Element::AssertedEvent)                                 { |event| event.update_input('User', "User 1 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Elements::Mobile::Inputs::ToggleInput::ChangedEvent)    { |event| event.assert_exists_input('Administrator', 'false') }
add_step! (RubyApp::Element::AssertedEvent)                                 { |event| event.update_input('Administrator', 'true') }
add_step! (RubyApp::Elements::Mobile::Inputs::ToggleInput::ChangedEvent)    { |event| event.assert_exists_link('Save') }
add_step! (RubyApp::Element::AssertedEvent)                                 { |event| event.click_link('Save') }
add_step! (RubyApp::Elements::Mobile::Click::ClickedEvent)                  { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                                 { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)                     { |event| event.assert_exists_link('Manage Users') }
add_step! (RubyApp::Element::AssertedEvent)                                 { |event| event.click_link('Manage Users') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)                     { |event| event.assert_exists_input('User') }
add_step! (RubyApp::Element::AssertedEvent)                                 { |event| event.update_input('User', "User 1 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Elements::Mobile::Inputs::ToggleInput::ChangedEvent)    { |event| event.assert_exists_input('Administrator', 'true') }
add_step! (RubyApp::Element::AssertedEvent)                                 { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                                 { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)                     { |event| event.execute {} }

# Change an administrator to a user
add_step! (RubyApp::Element::ExecutedEvent)                                 { |event| event.execute { Pike::User.create_user!("User 2 of #{Pike::Session.identity.user.id}", true) } }
add_step! (RubyApp::Element::ExecutedEvent)                                 { |event| event.assert_exists_link('Manage Users') }
add_step! (RubyApp::Element::AssertedEvent)                                 { |event| event.click_link('Manage Users') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)                     { |event| event.assert_exists_input('User') }
add_step! (RubyApp::Element::AssertedEvent)                                 { |event| event.update_input('User', "User 2 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Elements::Mobile::Inputs::ToggleInput::ChangedEvent)    { |event| event.assert_exists_input('Administrator', 'true') }
add_step! (RubyApp::Element::AssertedEvent)                                 { |event| event.update_input('Administrator', 'false') }
add_step! (RubyApp::Elements::Mobile::Inputs::ToggleInput::ChangedEvent)    { |event| event.assert_exists_link('Save') }
add_step! (RubyApp::Element::AssertedEvent)                                 { |event| event.click_link('Save') }
add_step! (RubyApp::Elements::Mobile::Click::ClickedEvent)                  { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                                 { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)                     { |event| event.assert_exists_link('Manage Users') }
add_step! (RubyApp::Element::AssertedEvent)                                 { |event| event.click_link('Manage Users') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)                     { |event| event.assert_exists_input('User') }
add_step! (RubyApp::Element::AssertedEvent)                                 { |event| event.update_input('User', "User 2 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Elements::Mobile::Inputs::ToggleInput::ChangedEvent)    { |event| event.assert_exists_input('Administrator', 'false') }
add_step! (RubyApp::Element::AssertedEvent)                                 { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                                 { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)                     { |event| event.execute {} }

# Go back to work list
add_step! (RubyApp::Element::ExecutedEvent)                                 { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                                 { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                                  { |event| event.assert_exists_link('tap to add a task') }
add_step! (RubyApp::Element::AssertedEvent)                                 { |event| event.execute {} }

load_script! 'common/logoff'
