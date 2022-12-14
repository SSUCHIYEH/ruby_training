require 'rails_helper'
require 'faker'

RSpec.describe 'Users management', type: :feature do
  include_context "with user stuff"
  let!(:user) { create(:user) }
  let(:normal) { User.human_attribute_name("role.normal") }
  let(:button_signout) { I18n.t('signout') }

  describe 'login' do
    before { visit login_path }

    context "when input with user data" do
      it do
        user_login(user)
        expect(page).to have_content(I18n.t('message.signin_succeed'))
      end
    end
  end

  describe 'sign_up' do
    before do
      visit sign_up_path
    end

    context "when fill form click admin" do
      it do
        sign_up_user(Faker::Name.last_name, Faker::Coffee.variety)
        click_button btn_create
        expect(page).to have_content(I18n.t('message.signup_succeed'))
      end
    end
  end

  describe 'sign_out' do
    before do
      user_login(user)
      visit tasks_path
    end

    context "when click sign_out button" do
      it do
        click_button button_signout
        expect(page).to have_content(I18n.t('message.signout_succeed'))
      end
    end
  end
end
