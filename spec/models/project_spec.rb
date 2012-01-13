require 'spec_helper'

require 'pike/models/project'
require 'pike/models/task'
require 'pike/models/user'

describe Pike::Project do
  include_context 'Pike::Application'

  describe 'positive' do

    describe 'should belong to a user' do

      it { should belong_to(:user).of_type(Pike::User) }

    end

    describe 'should have many tasks' do

      it { should have_many(:tasks).of_type(Pike::Task) }

    end

    describe 'should define standard properties' do

      it { should be_stored_in(:projects) }
      it { should be_timestamped_document }
      it { should be_paranoid_document }

    end

    describe 'should define other properties' do

      it { should have_field(:name).of_type(String) }

    end

    describe 'should validate other properties' do

      it { should validate_presence_of(:name) }
      it { should validate_uniqueness_of(:name).scoped_to([:user_id]) }

    end

  end

  describe 'negative' do
  end

end
