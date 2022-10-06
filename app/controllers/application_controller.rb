class ApplicationController < ActionController::Base
  def verify_user!
    if session[:user_id].present?
      @current_user = User.find_by(id: session[:user_id])
    else
      redirect_to login_path
    end
  end
end
