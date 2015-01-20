class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:username, :first_name, :last_name, :email, :password,
                                 :password_confirmation, :city_id)
  end

  def account_update_params
    params.require(:user).permit(:username, :first_name, :last_name, :email, :password,
                                 :password_confirmation, :current_password, :city_id)
  end
end