require 'rubygems'
require 'bundler/setup'

require 'aws/s3'
require 'aws/ses'
require 'fastercsv'
require 'fileutils'

require 'ruby_app'

module Pike

  module System

    module Actions
      require 'pike'
      require 'pike/elements/mail'

      class ReportExportAction < Pike::System::Action

        belongs_to :user, :class_name => 'Pike::User'

        field :date, :type => Date

        validates_presence_of :date

        def execute
          RubyApp::Log.duration("#{RubyApp::Log.prefix(self, __method__)} self.user.url=#{self.user.url.inspect} self.date=#{self.date.inspect}") do
            file = File.join(File.dirname(__FILE__), '.temporary', "#{self.id.to_s}.csv")
            self.generate_report(file)
            self.mail_report(file)
            self.delete_report(file)
          end
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
          service = AWS::SES::Base.new(:access_key_id     => ENV['AMAZON_ACCESS_KEY'] || Pike::Application.configuration.amazon.access_key,
                                       :secret_access_key => ENV['AMAZON_SECRET_KEY'] || Pike::Application.configuration.amazon.secret_key)
          RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} file=#{file.inspect}")
          RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} self.first_date=#{self.first_date.inspect}")

          html_body = Pike::Elements::Mail::ReportMail.new(file, self.first_date).render(:html)
          html_body.each_line do |line|
            RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} :html_body=#{line.inspect}")
          end

          service.send_email(:to        => Pike::Application.configuration.mail.to || self.user.url,
                             :source    => Pike::Application.configuration.mail.from,
                             :subject   => "Summary For The Week Of #{self.first_date.strftime(Pike::Application.configuration.format.date.short)}",
                             :html_body => Pike::Elements::Mail::ReportMail.new(file, self.first_date).render(:html))
        end

        def delete_report(file)
          FileUtils.rm(file)
        end

      end

    end

  end

end
