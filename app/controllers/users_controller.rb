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
      redirect_to tasks_path, notice: t('messege.signup_succeed')
    else
      render :new, notice: t('messege.input_error')
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :role)
  end
end
