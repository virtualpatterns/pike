# Logon
add_step! (RubyApp::Element::Event)                           { |event| event.delay(Random.rand(1500)).click_link('Random') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.execute {} }

# Go to projects
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.delay(Random.rand(1500)).click_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.delay(Random.rand(1500)).click_link('Projects') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.execute {} }

# Create a project
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.delay(Random.rand(1500)).click_link('tap to add a project') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.delay(Random.rand(1500)).update_input('Name', 'Project 01') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.delay(Random.rand(1500)).click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.execute {} }

# Go to home
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.delay(Random.rand(1500)).click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.delay(Random.rand(1500)).click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.execute {} }

# Go to activities
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.delay(Random.rand(1500)).click_link('More ...') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.delay(Random.rand(1500)).click_link('Activities') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.execute {} }

# Create an activity
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.delay(Random.rand(1500)).click_link('tap to add an activity') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.delay(Random.rand(1500)).update_input('Name', 'Activity 01') }
add_step! (RubyApp::Elements::Mobile::Input::ChangedEvent)    { |event| event.delay(Random.rand(1500)).click_link('Done') }
add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.execute {} }

# Go to home
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.delay(Random.rand(1500)).click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.delay(Random.rand(1500)).click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.execute {} }

# Logoff
add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.delay(Random.rand(1500)).click_link('Logoff') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)       { |event| event.execute {} }
