module Admin
  class UsersController < ApplicationController
    before_action :verify_admin!
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
      flash.alert = if @user.destroy
                      t("message.delete_user_succeed")
                    else
                      t('message.delete_user_failed')
                    end
      redirect_to admin_path
    end

    private

    def user_params
      params.require(:user).permit(:name, :password, :role)
    end

    def find_user
      @user = User.find_by(id: params[:id])
    end

    def verify_admin!
      return if current_user&.admin?

      redirect_to tasks_path, notice: t('message.require_admin')
    end
  end
end
