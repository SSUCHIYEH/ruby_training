class UsersController < ApplicationController
  def index
    @user = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to tasks_path, notice: '帳號註冊成功'
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :role)
  end
end
