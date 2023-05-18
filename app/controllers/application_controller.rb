class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone_num, :address])

    devise_parameter_sanitizer.permit(:sign_up, keys: [:phone_number, :address, :first_name, :last_name])
  end
end
