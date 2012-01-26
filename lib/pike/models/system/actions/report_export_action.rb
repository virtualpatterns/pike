require 'rubygems'
require 'bundler/setup'

require 'aws/s3'
require 'aws/ses'
require 'fastercsv'
require 'fileutils'

require 'ruby_app/log'

module Pike

  module System

    module Actions
      require 'pike/application'
      require 'pike/version'

      class ReportExportAction < Pike::System::Action

        belongs_to :user, :class_name => 'Pike::User'

        field :date, :type => Date

        validates_presence_of :date

        def process!
          RubyApp::Log.duration("#{self.class}##{__method__} self.user.url=#{self.user.url.inspect} self.date=#{self.date.inspect}") do
            file = File.join(File.dirname(__FILE__), '.temporary', "#{self.id.to_s}.csv")
            self.generate_report(file)
            self.mail_report(file)
            self.delete_report(file)
          end
          self.destroy
        end

        def first_date
          self.date - self.date.wday
        end

        def generate_report(file)
          directory = File.dirname(file)
          FileUtils.mkdir_p(directory)
          FasterCSV.open(file, 'w') do |report|
            header = ['User',
                      'Week Of',
                      'Project']
            self.user.project_properties.each do |name|
              header += [name]
            end
            header += ['Activity']
            self.user.activity_properties.each do |name|
              header += [name]
            end
            self.user.task_properties.each do |name|
              header += [name]
            end
            header += ['Sunday',
                       'Monday',
                       'Tuesday',
                       'Wednesday',
                       'Thursday',
                       'Friday',
                       'Saturday']
            report << header
            self.user.tasks.each do |task|
              row = [self.user.url,
                     self.first_date,
                     task.project.name]
              self.user.project_properties.each do |name|
                row += [task.project.read_attribute(name)]
              end
              row += [task.activity.name]
              self.user.activity_properties.each do |name|
                row += [task.activity.read_attribute(name)]
              end
              self.user.task_properties.each do |name|
                row += [task.read_attribute(name)]
              end
              (0..6).each do |index|
                date = self.first_date + index
                work = task.work.where_date(date).first
                if work && work.duration && work.duration > 0
                  row += [work.duration]
                else
                  row += [0]
                end
              end
              report << row
            end
          end
        end

        def mail_report(file)
          RubyApp::Log.debug("#{self.class}##{__method__} Pike::Application.configuration.amazon.access_key=#{Pike::Application.configuration.amazon.access_key.inspect}")
          RubyApp::Log.debug("#{self.class}##{__method__} Pike::Application.configuration.amazon.secret_key=#{Pike::Application.configuration.amazon.secret_key.inspect}")

          AWS::S3::Base.establish_connection!(:access_key_id => Pike::Application.configuration.amazon.access_key,
                                              :secret_access_key => Pike::Application.configuration.amazon.secret_key)
          name = file.gsub(Pike::ROOT, '')
          File.open(file, 'r') do |file|
            AWS::S3::S3Object.store(name, file, 'Pike')
          end
          url = AWS::S3::S3Object.url_for(name, 'Pike', :expires_in => 60 * 60 * 24)

          service = AWS::SES::Base.new(:access_key_id     => Pike::Application.configuration.amazon.access_key,
                                       :secret_access_key => Pike::Application.configuration.amazon.secret_key)
          service.send_email(:to        => Pike::Application.configuration.mail.to || self.user.url,
                             :source    => '"Pike" <virtualpatterns@sympatico.ca>',
                             :subject   => "Pike Summary For The Week Of #{self.first_date.strftime(Pike::Application.configuration.format.date.short)}",
                             :text_body => "Your weekly summary is available for the next 24 hours at #{url}.")
        end

        def delete_report(file)
          FileUtils.rm(file)
        end

      end

    end

  end

end
