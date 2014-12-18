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

  def authenticate_user!
    redirect_to new_user_registration_url unless user_signed_in?
  end

  # def after_sign_in_path_for(resource)
  #   binding.pry
  #   # sign_in_url = url_for(:action => 'new', :controller => 'sessions', :only_path => false, :protocol => 'http')
  #   # if request.referer == sign_in_url
  #   #   super
  #   # else
  #     my_return_to = session[:my_return_to]
  #     session[:my_return_to] = nil
  #     my_return_to || stored_location_for(resource) || request.referer || root_path
  #   # end
  # end
end
