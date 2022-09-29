class TasksController < ApplicationController
  before_action :find_task, only: %i[edit update destroy]

  def index
    @tasks = Task.search_by_param(*params.slice(:title, :status).values)
    if params[:order].present?
      order_by = params[:order].split(' ')
      @tasks = @tasks.sort_by_param(order_by[0], order_by[1]).page(params[:page])
    else
      @tasks = @tasks.sort_by_param.page(params[:page])
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

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
    params.require(:task).permit(:title, :content, :start_time, :end_time, :status, :priority)
  end

  def find_task
    @task = Task.find_by(id: params[:id])
  end
end
