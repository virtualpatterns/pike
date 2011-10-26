require 'spec_helper'

require 'models/activity'
require 'models/project'
require 'models/task'
require 'models/user'

describe Pike::User do
  include_context 'Pike::Application'

  describe 'positive' do

    describe 'should have many projects, activities, and tasks' do

      it { should have_many(:projects).of_type(Pike::Project) }
      it { should have_many(:activities).of_type(Pike::Activity) }
      it { should have_many(:tasks).of_type(Pike::Task) }

    end

    describe 'should define standard properties' do

      it { should be_stored_in(:users) }
      it { should be_timestamped_document }
      it { should be_paranoid_document }

    end

    describe 'should define other properties' do

      it { should have_field(:url).of_type(String) }

    end

    describe 'should validate other properties' do

      it { should validate_presence_of(:url) }
      it { should validate_uniqueness_of(:url).scoped_to(:deleted_at) }

    end

    describe 'should respond to some methods' do
      specify { Pike::User.should respond_to :get_user }
      specify { Pike::User.should respond_to :where_url }
    end

  end

  describe 'negative' do
  end

end
