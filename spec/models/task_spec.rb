require 'spec_helper'

require 'models/activity'
require 'models/project'
require 'models/task'
require 'models/user'

describe Pike::Task do
  include_context 'Pike::Application'

  describe 'positive' do

    describe 'should belong to a user, project, and activity' do

      it { should belong_to(:user).of_type(Pike::User) }
      it { should belong_to(:project).of_type(Pike::Project) }
      it { should belong_to(:activity).of_type(Pike::Activity) }

    end

    describe 'should define standard properties' do

      it { should be_stored_in(:tasks) }
      it { should be_timestamped_document }
      it { should be_paranoid_document }

    end

    describe 'should define other properties' do

      it { should have_field(:flag).of_type(Integer).with_default_value_of(Pike::Task::FLAG_NORMAL) }
      it { should have_field(:_project_name).of_type(String) }
      it { should have_field(:_activity_name).of_type(String) }

    end

    describe 'should validate other properties' do

      it { should validate_presence_of(:flag) }

    end

    describe 'should validate references' do

      it { should validate_presence_of(:user) }
      it { should validate_presence_of(:project) }
      it { should validate_presence_of(:activity) }
      it { should validate_uniqueness_of(:activity_id).scoped_to([:project_id, :deleted_at]) }

    end

  end

  describe 'negative' do
  end

end
