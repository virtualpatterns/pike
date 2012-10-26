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
      require 'pike/elements/mail'
      require 'pike/models/system/action'

      class WorkReportExportAction < Pike::System::Action

        belongs_to :user, :class_name => 'Pike::User'

        field :date, :type => Date

        validates_presence_of :date

        def execute
          RubyApp::Log.duration(RubyApp::Log::INFO, "ACTION    #{RubyApp::Log.prefix(self, __method__)} self.user.url=#{self.user.url.inspect} self.date=#{self.date.inspect}") do
            file = File.join(File.dirname(__FILE__), '.temporary', "#{self.id.to_s}.csv")
            self.create_report(file)
            self.mail_report(file)
            self.delete_report(file)
          end
        end

        def create_report(file)
          directory = File.dirname(file)
          FileUtils.mkdir_p(directory)
          FasterCSV.open(file, 'w') do |report|
            header = ['User',
                      'Week Of',
                      'Project']
            self.user.properties.where_project.each do |property|
              header += [property.name]
            end
            header += ['Activity']
            self.user.properties.where_activity.each do |property|
              header += [property.name]
            end
            self.user.properties.where_task.each do |property|
              header += [property.name]
            end
            header += ['Sunday',
                       'Monday',
                       'Tuesday',
                       'Wednesday',
                       'Thursday',
                       'Friday',
                       'Saturday']
            report << header
            self.user.tasks.all.each do |task|
              row = [self.user.url,
                     self.date.week_start,
                     task.project.name]
              self.user.properties.where_project.each do |property|
                value = task.project.values.where_property(property).first
                row += [value ? value.value : nil]
              end
              row += [task.activity.name]
              self.user.properties.where_activity.each do |property|
                value = task.activity.values.where_property(property).first
                row += [value ? value.value : nil]
              end
              self.user.properties.where_task.each do |property|
                value = task.values.where_property(property).first
                row += [value ? value.value : nil]
              end
              (0..6).each do |index|
                date = self.date.week_start + index
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
          service.send_email(:to        => Pike::Application.configuration.mail.to || self.user.url,
                             :source    => Pike::Application.configuration.mail.from,
                             :subject   => "Weekly Summary",
                             :html_body => Pike::Elements::Mail::WorkReportMail.new(file, self.date).render(:html))
        end

        def delete_report(file)
          FileUtils.rm(file)
        end

      end

    end

  end

end
