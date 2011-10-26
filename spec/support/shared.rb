shared_context 'Pike::Application' do

  before(:all) do
    #options = {:application_class => Pike::Application,
    #           :session_class => Pike::Session,
    #           :log_path => File.join(File.dirname(__FILE__), %w[.. .. log application.log]),
    #           :configuration_paths => File.join(File.dirname(__FILE__), %w[.. .. config.yml])}
    #Pike::Application.create(options)
  end

  after(:all) do
    #Pike::Application.destroy
  end

end
