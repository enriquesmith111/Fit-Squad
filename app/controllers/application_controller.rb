class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # This method is responsible for configuring permitted parameters
  # for Devise actions (sign-up and account update).
  def configure_permitted_parameters
    # For the sign-up action, permit the 'name' attribute.
    # This allows users to provide their name when signing up.
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])

    # For the account update action, also permit the 'name' attribute.
    # This allows users to update their name in their profiles.
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
