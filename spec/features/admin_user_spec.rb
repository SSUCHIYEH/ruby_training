require 'rails_helper'
require 'faker'

RSpec.describe 'Admin Users', type: :feature do
  let!(:user) { create(:user, name: 'ADMIN') }
  let(:normal) { User.human_attribute_name("role.normal") }
  let(:button_signout) { I18n.t('signout') }

  include_context "with user stuff"

  before do
    user_login(user)
    visit admin_path
  end

  describe 'get users' do
    before { visit tasks_path }

    context "when click admin tab" do
      it do
        find('#tab_admin').click
        refresh
        expect(find("tbody tr:nth-child(1) #name")).to have_content('ADMIN')
      end
    end
  end

  describe 'sign_up' do
    context "when fill a new user" do
      it do
        find('#new_user').click
        sign_up_user('admin_create', Faker::Coffee.variety)
        click_button btn_create
        expect(page).to have_content(I18n.t('message.signup_succeed'))
        expect(page).to have_content('admin_create')
      end
    end
  end

  describe 'edit user' do
    before do
      create(:user, name: 'NEW')
      refresh
    end

    it { expect(find("tbody tr:nth-child(2) #name")).to have_content('NEW') }

    context "when update user data" do
      it do
        find("tbody tr:nth-child(2) #edit").click
        edit_user('UPDATE')
        expect(page).to have_content(I18n.t('message.update_user_succeed'))
        expect(find("tbody tr:nth-child(2) #name")).to have_content('UPDATE')
      end
    end
  end

  describe 'delete user' do
    before do
      create(:user, name: 'DELETE')
      refresh
    end

    it { expect(find("tbody tr:nth-child(2) #name")).to have_content('DELETE') }

    context "when click delete button" do
      it do
        find("tbody tr:nth-child(2) #delete").click
        expect(page).to have_content(I18n.t('message.delete_user_succeed'))
        expect(page).not_to have_content('DELETE')
      end
    end
  end

  describe 'get user tasks' do
    let!(:have_task_user) { create(:user, name: 'HAVETASK') }

    before do
      create(:task, title: 'NEWTASK', user: have_task_user)
      refresh
    end

    it { expect(find("tbody tr:nth-child(2) #name")).to have_content('HAVETASK') }

    context "when user create task" do
      it do
        expect(find("tbody tr:nth-child(2) #tasks_number")).to have_content('1')
        find("tbody tr:nth-child(2) #tasks").click
        refresh
        expect(page).to have_content('NEWTASK')
      end
    end
  end

  def edit_user(name)
    within("#form_user") do
      fill_in "user_name", with: name
    end
    click_button btn_update
  end
end
