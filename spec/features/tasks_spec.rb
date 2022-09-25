require 'rails_helper'
require 'factories/task'

RSpec.describe 'Tasks management', type: :feature do
  before do
    create(:task, :init, title: "INIT")
    create(:task, :init, title: "NEW")
  end

  it "tasks order by create_at desc" do
    visit "/tasks"
    expect(find("tbody tr:nth-child(1) #title")).to have_content("NEW")
    expect(find("tbody tr:nth-child(2) #title")).to have_content("INIT")
  end
end
