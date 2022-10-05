class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to tasks_path, notice: t('message.signup_succeed')
    else
      render :new, notice: t('message.input_error')
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :role)
  end
end
