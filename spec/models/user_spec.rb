require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Association' do
    it { is_expected.to have_many(:tasks).dependent(:destroy) }
  end

  describe 'Before_destroy' do
    let!(:admin) { create(:user, :admin) }

    context 'when delete last admin' do
      it do
        admin.destroy
        expect(described_class.count).to eq 1
      end
    end
  end
end
