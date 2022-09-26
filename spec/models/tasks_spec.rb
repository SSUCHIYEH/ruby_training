require 'rails_helper'
require 'factories/task'
require 'faker'

RSpec.describe Task, type: :model do
  describe 'title' do
    let(:task) { build(:task, :init, title: "") }

    it "not_allow_blank" do
      task.save
      expect(task.errors.full_messages.first).to include("Title不能為空白")
    end
  end

  describe 'end_time' do
    let(:task) { build(:task, :init, :period_error) }

    it "greater_or_qual_to start_time" do
      task.save
      expect(task.errors.full_messages.first).to include("End time必須大於或等於")
    end
  end
end
