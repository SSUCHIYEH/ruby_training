require 'rails_helper'
require 'factories/task'

RSpec.describe 'Tasks management', type: :feature do
  describe 'order_by' do
    let!(:tasks) do # rubocop:disable RSpec/LetSetup
      [create(:task, :next_year, title: "INIT"), create(:task, :init, title: "NEW")]
    end

    before do
      visit "/tasks"
    end

    context "when default" do
      it "by create_at desc" do
        expect(find("tbody tr:nth-child(1) #title")).to have_content("NEW")
        expect(find("tbody tr:nth-child(2) #title")).to have_content("INIT")
      end
    end

    context "when click end_time" do
      it "end_time_desc" do
        find("#order_menu #end_time_desc").click
        expect(find("tbody tr:nth-child(1) #title")).to have_content("INIT")
        expect(find("tbody tr:nth-child(2) #title")).to have_content("NEW")
      end

      it "end_time_asc" do
        find("#order_menu #end_time_asc").click
        expect(find("tbody tr:nth-child(1) #title")).to have_content("NEW")
        expect(find("tbody tr:nth-child(2) #title")).to have_content("INIT")
      end
    end
  end

  describe 'search' do
    let!(:not_started_tasks) { create_list(:task, 3, :init, title: "not_started") } # rubocop:disable RSpec/LetSetup
    let!(:complete_tasks) { create_list(:task, 3, :init, :complete, title: "complete") } # rubocop:disable RSpec/LetSetup
    let(:zh_not_started) { Task.human_attribute_name("status.not_started") }
    let(:zh_complete) { Task.human_attribute_name("status.complete") }

    before do
      visit "/tasks"
    end

    context "with title" do
      it do
        within("#search") do
          fill_in "title", with: "not_started"
        end
        click_button I18n.t("search")

        expect(find("tbody")).not_to have_content("complete")
        expect(find("tbody")).to have_content("not_started")
      end
    end

    context "with status" do
      it do
        within("#search") do
          select(zh_complete, from: "status")
        end
        click_button I18n.t("search")

        expect(find("tbody")).not_to have_content(zh_not_started)
        expect(find("tbody")).to have_content(zh_complete)
      end
    end

    context "with title and status" do
      it do
        within("#search") do
          fill_in "title", with: "complete"
          select(zh_complete, from: "status")
        end
        click_button I18n.t("search")
        expect(find("tbody")).to have_content("complete")
        expect(find("tbody")).to have_content(zh_complete)
      end
    end
  end
end
