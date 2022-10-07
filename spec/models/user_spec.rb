require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Association' do
    it { is_expected.to have_many(:tasks).dependent(:destroy) }
  end

  describe 'Before_destroy' do
    subject { admin.destroy }

    let!(:admin) { create(:user, :admin) }

    context 'when delete last admin' do
      it { is_expected.to be_falsy }
    end
  end
end
