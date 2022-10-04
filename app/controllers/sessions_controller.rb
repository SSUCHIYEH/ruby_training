class SessionsController < ApplicationController
  before_action :find_session_user, only: %i[create destroy]

  def new; end

  def create
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to tasks_path
    else
      redirect_to root_path, notice: t('input_error')
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: '已登出'
  end

  private

  def find_session_user
    @user = User.find_by(name: params[:name])
  end
end
