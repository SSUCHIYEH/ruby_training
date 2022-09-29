require 'rails_helper'
require 'factories/task'
require 'faker'

RSpec.describe Task, type: :model do
  let(:task) { build(:task, :init) }

  describe 'Validation' do
    subject(:valid) { task.valid? }

    # 資料齊全通過驗證
    it { is_expected.to be_truthy }

    # 錯誤情況
    context "when title is blank" do
      it do
        task.title = ""
        expect { valid }.to change { task.errors.messages[:title].first }.to include("不能為空白")
      end
    end

    context "when end_time is less_than start_time" do
      it do
        task.end_time = Faker::Date.in_date_period(year: 2022, month: 8)
        expect { valid }.to change { task.errors.messages[:end_time].first }.to include("必須大於或等於")
      end
    end
  end

  describe '.search_by_param' do
    let!(:not_started_tasks) { create_list(:task, 3, :init, title: "not_started") }
    let!(:complete_tasks) { create_list(:task, 3, :init, :complete, title: "complete") }

    context "with title" do
      subject { described_class.search_by_param("not_started", "") }

      it { is_expected.not_to match_array(complete_tasks) }
      it { is_expected.to match_array(not_started_tasks) }
    end

    context "with status" do
      subject { described_class.search_by_param("", "2") }

      it { is_expected.not_to match_array(not_started_tasks) }
      it { is_expected.to match_array(complete_tasks) }
    end

    context "with title and status" do
      subject { described_class.search_by_param("complete", "2") }

      it { is_expected.not_to match_array(not_started_tasks) }
      it { is_expected.to match_array(complete_tasks) }
    end
  end
end
