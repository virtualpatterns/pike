load_script! 'common/logon_random'

# Go to friends
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_text('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Friends') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Friends') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Friends') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Delete a friend
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_friendship!("Friend 1 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Friends') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Friends') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link("Friend 1 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link("Friend 1 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text("Friend 1 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Delete Friend') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Delete Friend') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Are you sure you want to delete this friend?') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Yes') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Yes') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_not_exists_text("Friend 1 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Don't delete a friend
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_friendship!("Friend 2 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Friends') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Friends') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link("Friend 2 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link("Friend 2 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text("Friend 2 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Delete Friend') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Delete Friend') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Are you sure you want to delete this friend?') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('No') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('No') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text("Friend 2 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Go back to work list
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.tap_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('tap to add a task') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

load_script! 'common/logoff'
