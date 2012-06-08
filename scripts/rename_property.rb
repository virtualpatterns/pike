load_script! 'common/logon_random'

# Go to more ...
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_text('More ...') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('More') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Rename a property
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_project!('Project 1', false, 'Property 1' => 'Value 1') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_activity!('Activity 1', false, 'Property 1' => 'Value 1') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_task!('Project 1', 'Activity 1', Pike::Task::FLAG_LIKED, 'Property 1' => 'Value 1') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Rename Property') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Rename Property') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('From') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('From', 'Property 1') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_input('To') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('To', 'Property 2') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Are you sure you want to change the name of the property \'Property 1\' to \'Property 2\'?') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Yes') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Yes') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert('Project 1, Property 2 == Value 1') { Pike::Session.identity.user.get_project_property('Project 1', 'Property 2') == 'Value 1' } }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert('Activity 1, Property 2 == Value 1') { Pike::Session.identity.user.get_activity_property('Activity 1', 'Property 2') == 'Value 1' } }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert('Project 1, Activity 1, Property 2 == Value 1') { Pike::Session.identity.user.get_task_property('Project 1', 'Activity 1', 'Property 2') == 'Value 1' } }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Don't rename a property
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_project!('Project 2', false, 'Property 3' => 'Value 2') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_activity!('Activity 2', false, 'Property 3' => 'Value 2') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.execute { Pike::Session.identity.user.create_task!('Project 2', 'Activity 2', Pike::Task::FLAG_LIKED, 'Property 3' => 'Value 2') } }
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Rename Property') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Rename Property') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('From') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('From', 'Property 3') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_input('To') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('To', 'Property 4') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('Are you sure you want to change the name of the property \'Property 3\' to \'Property 4\'?') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('No') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('No') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert('Project 2, Property 3 == Value 2') { Pike::Session.identity.user.get_project_property('Project 2', 'Property 3') == 'Value 2' } }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert('Activity 2, Property 3 == Value 2') { Pike::Session.identity.user.get_activity_property('Activity 2', 'Property 3') == 'Value 2' } }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert('Project 2, Activity 2, Property 3 == Value 2') { Pike::Session.identity.user.get_task_property('Project 2', 'Activity 2', 'Property 3') == 'Value 2' } }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

# Rename from and to blank properties
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Rename Property') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Rename Property') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('From and to values are both required.') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('OK') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('OK') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.execute {} }

# Rename from a blank property
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Rename Property') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Rename Property') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('To') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('To', 'Property 5') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('From and to values are both required.') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('OK') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('OK') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.execute {} }

# Rename to a blank property
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Rename Property') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Rename Property') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_input('From') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.update_input('From', 'Property 6') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.assert_exists_link('Done') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Done') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_text('From and to values are both required.') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('OK') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('OK') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.execute {} }

# Go back to work list
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('Back') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_exists_link('tap to add a task') }
add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

load_script! 'common/logoff'
