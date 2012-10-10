load_script! 'common/logon_random'

# Go to friends
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_text('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Friends') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Friends') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Friends') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Create an introduction
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::User.create_user!("Friend 01 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add a friend') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add a friend') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('User') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('User', "Friend 01 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_input('Message') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Message', 'Be my friend!') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('An introduction will be sent to the user specified.') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('OK') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('OK') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_not_exists_link("Friend 01 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Create an invalid introduction
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add a friend') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add a friend') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('User') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('User', "Friend 02 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text("The user Friend 02 of #{Pike::Session.identity.user.id} does not exist.") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('OK') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('OK') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_not_exists_link("Friend 02 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Accept an introduction
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Introduction.create_introduction!("Friend 03 of #{Pike::Session.identity.user.id}", Pike::Session.identity.user.url, 'Be my friend!') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('tap to manage friends') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to manage friends') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Introductions') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link("Friend 03 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link("Friend 03 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text("Friend 03 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Be my friend!') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Accept') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Accept') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Any shared projects and activities will be added momentarily.') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('OK') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('OK') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_not_exists_text('Introductions') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link("Friend 03 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Ignore an introduction
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Introduction.create_introduction!("Friend 04 of #{Pike::Session.identity.user.id}", Pike::Session.identity.user.url, 'Be my friend!') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('tap to manage friends') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to manage friends') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Introductions') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link("Friend 04 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link("Friend 04 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text("Friend 04 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Be my friend!') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Ignore') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Ignore') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Are you sure you want to ignore this introduction?') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Yes') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Yes') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_not_exists_link("Friend 04 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Don't ignore an introduction
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Introduction.create_introduction!("Friend 05 of #{Pike::Session.identity.user.id}", Pike::Session.identity.user.url, 'Be my friend!') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('tap to manage friends') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to manage friends') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Introductions') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link("Friend 05 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link("Friend 05 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text("Friend 05 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Be my friend!') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Ignore') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Ignore') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Are you sure you want to ignore this introduction?') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('No') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('No') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text('Introductions') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link("Friend 05 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Go back to work list
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

load_script! 'common/logoff'
