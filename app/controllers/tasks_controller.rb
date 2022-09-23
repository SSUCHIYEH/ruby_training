class TasksController < ApplicationController
    before_action :find_task, only: [:edit, :update, :destroy]

    def index
        @tasks = Task.all
    end

    def new
        @task = Task.new
    end

    def create
        @task = Task.new(task_params)

        if @task.save!
            redirect_to tasks_path, notice: "新增任務成功"
        else 
            render :new, notice: "任務新增失敗!"
        end
    end

    def edit
    end
    
    def update    
        if @task.update(task_params)
          # 成功
          redirect_to tasks_path, notice: "任務更新成功!"
        else
          # 失敗
          render :edit
        end
    end

    def destroy
        @task.destroy
        redirect_to tasks_path, notice: "任務刪除成功!"
    end

    private
    
    def task_params
        params.require(:task).permit(:title, :content, :start_time, :end_time, :status, :priority, :user_id)
    end

    def find_task
        @task = Task.find_by(id: params[:id])
    end
end
