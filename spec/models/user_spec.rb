require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    build(:user)
  end

  context 'when association with tasks' do
    it { is_expected.to have_many(:tasks).dependent(:destroy) }
  end
end
