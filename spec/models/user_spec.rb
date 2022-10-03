require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Association' do
    it { is_expected.to have_many(:tasks).dependent(:destroy) }
  end
end
