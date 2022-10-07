require 'rails_helper'
require 'faker'

RSpec.describe Tag, type: :model do
  describe 'Association' do
    it { is_expected.to have_many(:tasks).through(:tags_tasks) }
  end
end
