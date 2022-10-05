class TasksController < ApplicationController
  before_action :verify_user!
  before_action :find_task, only: %i[edit update destroy]

  def index
    @sort_result = sort_by_param
    @tasks = @sort_result.search_by_param(*params.slice(:title, :status).values).page(params[:page])
  end

  def new
    @task = Task.new
  end

  def create
    @task = @current_user.tasks.new(task_params)

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
      @current_user.tasks.sort_by_param(order_by[0], order_by[1])
    else
      @current_user.tasks.sort_by_param
    end
  end

  def verify_user!
    if session[:user_id].present?
      @current_user = User.find_by(id: session[:user_id])
    else
      redirect_to login_path
    end
  end
end
