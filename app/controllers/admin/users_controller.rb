module Admin
  class UsersController < ApplicationController
    before_action :verify_user!
    before_action :find_user, only: %i[edit update tasks destroy]
    def index
      @users = User.all
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)

      if @user.save
        redirect_to admin_path, notice: t('message.signup_succeed')
      else
        render :new, notice: t('message.input_error')
      end
    end

    def edit; end

    def update
      if @user.update(user_params)
        redirect_to admin_path, notice: t("message.update_user_succeed")
      else
        render :edit, notice: t("message.update_user_failed")
      end
    end

    def tasks
      @tasks = @user.tasks
    end

    def destroy
      @user.destroy
      redirect_to admin_path, notice: t("message.delete_user_succeed")
    end

    private

    def user_params
      params.require(:user).permit(:name, :password, :role)
    end

    def find_user
      @user = User.find_by(id: params[:id])
    end
  end
end
