load_script! 'common/logon_random'

# Import GitHub repositories
# add_step! (RubyApp::Element::ExecutedEvent)                   { |event| event.assert_exists_link('tap to refresh GitHub access') }
# add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to refresh GitHub access') }
# add_step! (RubyApp::Elements::Mobile::Page::LoadedEvent)      
# add_step! (RubyApp::Elements::Mobile::Page::LoadedEvent)      
# add_step! (RubyApp::Elements::Mobile::Page::LoadedEvent)      { |event| event.assert_exists_link('tap to import GitHub repositories') }
# add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.click_link('tap to import GitHub repositories') }
# add_step! (RubyApp::Element::UpdatedEvent)                    { |event| event.assert_not_exists_text('tap to import GitHub repositories') }
# add_step! (RubyApp::Element::AssertedEvent)                   { |event| event.execute {} }

load_script! 'common/logoff'
