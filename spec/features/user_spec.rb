require 'rails_helper'
require 'faker'

RSpec.describe 'Users management', type: :feature do
  include_context "with login stuff"
  let!(:user) { create(:user) }
  let(:normal) { User.human_attribute_name("role.normal") }
  let(:submit_create) { I18n.t('helpers.submit.create') }
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

    let(:user_attr) do
      {
        name: 'new_user',
        password: 'new_password'
      }
    end

    context "when sign_up with new user" do
      it do
        sign_up_user(Faker::Name.last_name, Faker::Coffee.variety)
        click_button submit_create
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

  def sign_up_user(name, password)
    within("#form_user") do
      fill_in "user_name", with: name
      fill_in "user_password", with: password
      select normal, from: "user_role"
    end
  end
end
