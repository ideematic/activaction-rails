class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_filter :pass_params
  #
  # def pass_params
  #   @params = params
  # end

  def authenticate_admin!
    if current_user && current_user.is_admin
      # fine
    else
      redirect_to new_user_session_path
    end
  end
end
