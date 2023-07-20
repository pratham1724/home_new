class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def client_signed_in?
    user_signed_in? && current_user.client?
  end
  helper_method :client_signed_in?

  def trainer_signed_in?
    user_signed_in? && current_user.trainer?
  end
  helper_method :trainer_signed_in?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
  end
end
