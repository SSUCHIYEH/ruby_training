require 'rails_helper'
require 'factories/task'

RSpec.describe 'Tasks', type: :request do
  let(:valid_attributes) do
    {
      title: 'task1',
      content: 'task1',
      start_time: '2022-09-22',
      end_time: '2022-09-23',
      status: 'NotStarted',
      priority: 'High'
    }
  end

  describe '.get_all' do
    it 'read all tasks' do
      create(:task)
      get tasks_path
      expect(response).to be_successful
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
      task = create(:task)
      get edit_task_path(task)
      expect(response).to be_successful
    end
  end

  describe '.create' do
    context 'with valid parameters' do
      it 'creates a new Task' do
        expect do
          post tasks_path, params: { task: valid_attributes }
        end.to change(Task, :count).by(1)
      end

      it 'redirects to tasks' do
        post tasks_path, params: { task: valid_attributes }
        expect(response).to redirect_to(tasks_path)
      end
    end
  end

  describe '.update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          title: 'task1',
          content: 'task1',
          start_time: '2022-09-22',
          end_time: '2022-09-23',
          status: 'NotStarted',
          priority: 'High'
        }
      end

      it 'updates the requested task' do
        task = create(:task)
        patch task_path(task), params: { task: new_attributes }
        last_task = Task.last
        expect(last_task.title).to eq('task1')
        expect(last_task.content).to eq('task1')
      end

      it 'redirects to the article' do
        task = Task.create! valid_attributes
        patch task_path(task), params: { task: new_attributes }
        task.reload
        expect(response).to redirect_to(tasks_path)
      end
    end
  end

  describe '.destroy' do
    it 'destroys the requested task' do
      task = Task.create! valid_attributes
      expect do
        delete task_path(task)
      end.to change(Task, :count).by(-1)
    end

    it 'redirects to the tasks list' do
      task = Task.create! valid_attributes
      delete task_path(task)
      expect(response).to redirect_to(tasks_path)
    end
  end
end
