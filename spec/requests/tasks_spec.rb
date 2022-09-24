# frozen_string_literal: true

require 'rails_helper'
require 'factories/task'
require 'faker'

RSpec.describe 'Tasks', type: :request do
  let!(:task) { create(:task, :init, title: 'TEST') }
  let(:valid_attributes) do
    {
      title: Faker::Hobby.activity,
      content: Faker::Lorem.sentence,
      start_time: Faker::Date.forward(days: 23),
      end_time: Faker::Date.forward(days: 23),
      status: 'notStarted',
      priority: 'high'
    }
  end

  describe '.get_all' do
    it 'read all tasks' do
      get tasks_path
      expect(response).to be_successful
      expect(response.body).to include("待處理")
      expect(response.body).to include("不急")
      expect(response.body).to include("TEST")
    end
  end

  describe '.new' do
    it 'new tasks' do
      get new_task_path
      expect(response).to be_successful
    end
  end

  describe '.edit' do
    it 'edit tasks' do
      get edit_task_path(task)
      expect(response).to be_successful
    end
  end

  describe '.create' do
    it 'creates a new Task and redirects to the Tasks page' do
      get new_task_path
      expect(response).to have_http_status(:ok)

      post tasks_path, params: { task: valid_attributes }

      expect(response).to redirect_to(tasks_path)
      follow_redirect!

      expect(response.body).to include("任務新增成功")
    end

    it 'does not render a different template' do
      get new_task_path
      expect(response).not_to redirect_to(tasks_path)
    end
  end

  describe '.update' do
    let(:new_attributes) do
      {
        title: 'UPDATE',
        content: Faker::Lorem.sentence,
        start_time: Faker::Date.forward(days: 23),
        end_time: Faker::Date.forward(days: 23),
        status: 'notStarted',
        priority: 'high'
      }
    end

    it 'updates the task and redirects to the Tasks page' do
      get edit_task_path(task)
      expect(response).to have_http_status(:ok)

      patch task_path(task), params: { task: new_attributes }
      task.reload
      expect(task.title).to eq('UPDATE')
      expect(task.status).to eq('notStarted')
    end
  end

  describe '.destroy' do
    it 'destroy the task and redirects to the tasks page' do
      delete task_path(task)

      expect(response).to redirect_to(tasks_path)
      follow_redirect!

      expect(response.body).to include('任務刪除成功')
    end
  end
end
