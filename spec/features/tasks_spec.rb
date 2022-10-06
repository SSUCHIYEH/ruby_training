require 'rails_helper'

RSpec.describe 'Tasks management', type: :feature do
  include_context "with user stuff"
  let!(:user) { create(:user) }

  before { user_login(user) }

  describe 'order' do
    before do
      create(:task, :low, :next_year, title: "next_year", user: user)
      create(:task, :high, title: "this_year", user: user)
      visit "/tasks"
    end

    let(:first_tr) { "tbody tr:nth-child(1) " }
    let(:second_tr) { "tbody tr:nth-child(2) " }
    let(:zh_high) { Task.human_attribute_name("priority.high") }
    let(:zh_low) { Task.human_attribute_name("priority.low") }

    context "when default order by create_at desc" do
      it do
        expect(find("#{first_tr}#title")).to have_content("this_year")
        expect(find("#{second_tr}#title")).to have_content("next_year")
      end
    end

    context "when order by end_time desc" do
      it do
        order_by("end_time", "desc")
        expect(find("#{first_tr}#title")).to have_content("next_year")
        expect(find("#{second_tr}#title")).to have_content("this_year")
      end
    end

    context "when order by end_time asc" do
      it do
        order_by("end_time", "asc")
        expect(find("#{first_tr}#title")).to have_content("this_year")
        expect(find("#{second_tr}#title")).to have_content("next_year")
      end
    end

    context "when order by priority desc" do
      it do
        order_by("priority", "desc")
        expect(find("#{first_tr}#priority")).to have_content(zh_high)
        expect(find("#{second_tr}#priority")).to have_content(zh_low)
      end
    end

    context "when order by priority asc" do
      it do
        order_by("priority", "asc")
        expect(find("#{first_tr}#priority")).to have_content(zh_low)
        expect(find("#{second_tr}#priority")).to have_content(zh_high)
      end
    end

    def order_by(attr, sort)
      within("#search") do
        select(I18n.t("order_options.#{attr}_#{sort}"), from: "order")
      end
      click_button I18n.t("search")
    end
  end

  describe 'search' do
    before do
      generate_not_started_tasks
      generate_complete_tasks
      visit "/tasks"
    end

    let(:zh_not_started) { Task.human_attribute_name("status.not_started") }
    let(:zh_complete) { Task.human_attribute_name("status.complete") }

    context "when search by title" do
      it do
        within("#search") do
          fill_in "title", with: "not_started"
        end
        click_button I18n.t("search")

        expect(find("tbody")).not_to have_content("complete")
        expect(find("tbody")).to have_content("not_started")
      end
    end

    context "when search by status" do
      it do
        within("#search") do
          select(zh_complete, from: "status")
        end
        click_button I18n.t("search")

        expect(find("tbody")).not_to have_content(zh_not_started)
        expect(find("tbody")).to have_content(zh_complete)
      end
    end

    context "when search by title and status" do
      it do
        search_complete_by_title_status
        click_button I18n.t("search")
        expect(find("tbody")).to have_content("complete")
        expect(find("tbody")).to have_content(zh_complete)
      end
    end
  end

  def generate_not_started_tasks
    create_list(:task, 3, title: "not_started", user: user)
  end

  def generate_complete_tasks
    create_list(:task, 3, :complete, title: "complete", user: user)
  end

  def search_complete_by_title_status
    within("#search") do
      fill_in "title", with: "complete"
      select(zh_complete, from: "status")
    end
  end
end
