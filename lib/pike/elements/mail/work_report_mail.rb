require 'rubygems'
require 'bundler/setup'

require 'ruby_app'

module Pike

  module Elements

    module Mail
      require 'pike'
      require 'pike/elements/mail/blank_mail'

      class WorkReportMail < Pike::Elements::Mail::BlankMail

        template_path(:all, File.dirname(__FILE__))

        def initialize(file, date)
          super()

          AWS::S3::Base.establish_connection!(:access_key_id      => ENV['AMAZON_ACCESS_KEY'] || Pike::Application.configuration.amazon.access_key,
                                              :secret_access_key  => ENV['AMAZON_SECRET_KEY'] || Pike::Application.configuration.amazon.secret_key)
          name = file.gsub(Pike::ROOT, '')
          File.open(file, 'r') do |file|
            AWS::S3::S3Object.store(name, file, 'Pike')
          end

          @url = AWS::S3::S3Object.url_for(name, 'Pike', :expires_in => 60 * 60 * 24)
          @date = date

        end

      end

    end

  end

end
