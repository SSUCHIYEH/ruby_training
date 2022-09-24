require 'rails_helper'
require 'factories/task'

RSpec.describe 'Tasks' do
  let(:task) { create(:task, :init, title: 'TEST') }

  describe '#order_by_created_at' do
    let(:new_task) { create(:task, :init) }

    it 'orders by created_at' do
      expect(Task.all) == [new_task, task]
    end
  end
end
