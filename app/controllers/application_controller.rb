class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  
  # Include the TeamContext concern for team-based authentication
  include TeamContext
  
  # Configure Devise to use username instead of email for authentication
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected
  
  def configure_permitted_parameters
    added_attrs = [:username, :email, :name, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: [:username, :password, :remember_me]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
