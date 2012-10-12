load_script! 'common/logon_random'

# Go to friends
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_text('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Friends') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Friends') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Friends') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Delete a friend
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_friendship!("Friend 01 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Friends') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Friends') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link("Friend 01 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link("Friend 01 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text("Friend 01 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Delete Friend') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Delete Friend') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Are you sure you want to delete this friend?') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Yes') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Yes') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_not_exists_link("Friend 01 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Don't delete a friend
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_friendship!("Friend 02 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Friends') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Friends') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link("Friend 02 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link("Friend 02 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text("Friend 02 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Delete Friend') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Delete Friend') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Are you sure you want to delete this friend?') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('No') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('No') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link("Friend 02 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Go back to work list
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

load_script! 'common/logoff'
