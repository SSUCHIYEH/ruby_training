require 'rails_helper'
require 'factories/task'

RSpec.describe 'Tasks management', type: :feature do
  describe 'order_by' do
    before do
      create(:task, :next_year, title: "INIT")
      create(:task, :init, title: "NEW")
    end

    context "when default" do
      it "by create_at desc" do
        visit "/tasks"
        expect(find("tbody tr:nth-child(1) #title")).to have_content("NEW")
        expect(find("tbody tr:nth-child(2) #title")).to have_content("INIT")
      end
    end

    context "when click end_time" do
      it "end_time_desc" do
        visit "/tasks"
        find("#order_menu #end_time_desc").click

        expect(find("tbody tr:nth-child(1) #title")).to have_content("INIT")
        expect(find("tbody tr:nth-child(2) #title")).to have_content("NEW")
      end

      it "end_time_asc" do
        visit "/tasks"
        find("#order_menu #end_time_asc").click

        expect(find("tbody tr:nth-child(1) #title")).to have_content("NEW")
        expect(find("tbody tr:nth-child(2) #title")).to have_content("INIT")
      end
    end
  end
end
