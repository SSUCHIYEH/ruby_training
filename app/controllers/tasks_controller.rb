class TasksController < ApplicationController
  before_action :find_task, only: %i[edit update destroy]

  def index
    if session[:user_id]
      @user_tasks = Task.includes(:user).where("user_id =?", session[:user_id])
      @sort_result = sort_by_param
      @tasks = @sort_result.search_by_param(*params.slice(:title, :status).values).page(params[:page])
    else
      redirect_to login_path
    end
  end

  def new
    @task = Task.new
  end

  def create
    new_task = {
      user_id: session[:user_id]
    }
    new_task.merge!(task_params)
    @task = Task.new(new_task)

    if @task.save
      redirect_to tasks_path, notice: t("message.create_task_succeed")
    else
      render :new, notice: t("message.create_task_failed")
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      # 成功
      redirect_to tasks_path, notice: t("message.update_task_succeed")
    else
      # 失敗
      render :edit, notice: t("message.update_task_failed")
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: t("message.delete_task_succeed")
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :start_time, :end_time, :status, :priority, :user_id)
  end

  def find_task
    @task = Task.find_by(id: params[:id])
  end

  def sort_by_param
    if params[:order].present?
      order_by = params[:order].split(' ')
      @user_tasks.sort_by_param(order_by[0], order_by[1])
    else
      @user_tasks.sort_by_param
    end
  end
end
