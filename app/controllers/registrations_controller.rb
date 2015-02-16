class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    User.permit_params params
  end

  def account_update_params
    User.permit_params params
  end
end