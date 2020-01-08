class ApplicationController < ActionController::Base
    before_action :authenticate_user!

    before_filter :configure_permitted_parameters, if: :devise_controller?

    protected

        def configure_permitted_parameters
            devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:fname, :lname, :email, :password) }
            devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:fname, :lname, :email, :password, :current_password, :is_female, :date_of_birth) }
        end
end 
