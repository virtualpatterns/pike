load_script! 'common/logon_random'

# Go to friends
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_text('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Friends') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Friends') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Friends') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Delete an introduction
# NOTE:  Must do this one BEFORE the next one
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::User.create_user!("Friend 01.1 of #{Pike::Session.identity.user.id}", "Friend 01.1 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Introduction.create_introduction!(Pike::Session.identity.user.url, "Friend 01.1 of #{Pike::Session.identity.user.id}", 'Be my friend!') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Friends') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Friends') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Introductions') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link("Friend 01.1 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link("Friend 01.1 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text("Friend 01.1 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Be my friend!') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Delete Introduction') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Delete Introduction') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Are you sure you want to delete this introduction?') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Yes') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Yes') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_not_exists_text('Introductions You Sent') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_not_exists_link("Friend 01.1 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Create an introduction
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::User.create_user!("Friend 01.0 of #{Pike::Session.identity.user.id}", "Friend 01.0 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to add a friend') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to add a friend') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('tap to select a user') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to select a user') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_search('tap to search by name') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_search('tap to search by name', "Friend 01.0 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link("Friend 01.0 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link("Friend 01.0 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('Message') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('Message', 'Be my friend!') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text('Introductions You Sent') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link("Friend 01.0 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Don't delete an introduction
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::User.create_user!("Friend 01.2 of #{Pike::Session.identity.user.id}", "Friend 01.2 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Introduction.create_introduction!(Pike::Session.identity.user.url, "Friend 01.2 of #{Pike::Session.identity.user.id}", 'Be my friend!') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Friends') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Friends') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Introductions') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link("Friend 01.2 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link("Friend 01.2 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text("Friend 01.2 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Be my friend!') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Delete Introduction') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Delete Introduction') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Are you sure you want to delete this introduction?') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('No') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('No') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text('Introductions You Sent') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link("Friend 01.2 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Accept an introduction
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::User.create_user!("Friend 02 of #{Pike::Session.identity.user.id}", "Friend 02 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Introduction.create_introduction!("Friend 02 of #{Pike::Session.identity.user.id}", Pike::Session.identity.user.url, 'Be my friend!') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('tap to manage friends') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to manage friends') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Introductions You Received') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link("Friend 02 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link("Friend 02 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text("Friend 02 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Be my friend!') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Accept Introduction') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Accept Introduction') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_not_exists_text('Introductions You Received') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link("Friend 02 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Ignore an introduction
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::User.create_user!("Friend 03 of #{Pike::Session.identity.user.id}", "Friend 03 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Introduction.create_introduction!("Friend 03 of #{Pike::Session.identity.user.id}", Pike::Session.identity.user.url, 'Be my friend!') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('tap to manage friends') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to manage friends') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Introductions You Received') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link("Friend 03 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link("Friend 03 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text("Friend 03 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Be my friend!') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Ignore Introduction') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Ignore Introduction') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Are you sure you want to ignore this introduction?') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Yes') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Yes') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_not_exists_text('Introductions You Received') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_not_exists_link("Friend 03 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Don't ignore an introduction
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::User.create_user!("Friend 04 of #{Pike::Session.identity.user.id}", "Friend 04 of #{Pike::Session.identity.user.id}") } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Introduction.create_introduction!("Friend 04 of #{Pike::Session.identity.user.id}", Pike::Session.identity.user.url, 'Be my friend!') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('tap to manage friends') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to manage friends') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Introductions You Received') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link("Friend 04 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link("Friend 04 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text("Friend 04 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_text('Be my friend!') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Ignore Introduction') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Ignore Introduction') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Are you sure you want to ignore this introduction?') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('No') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('No') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_text('Introductions You Received') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link("Friend 04 of #{Pike::Session.identity.user.id}") }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Go back to work list
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

load_script! 'common/logoff'
