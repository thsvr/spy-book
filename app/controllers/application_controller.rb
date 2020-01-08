class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:fname, :lname, :email, :password])
    devise_parameter_sanitizer.permit(:account_update, keys:
                                      %i[fname lname email password current_password is female date_of_birth])
  end
end
