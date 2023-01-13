class ApplicationController < ActionController::Base
  # helper_method :current_user
  before_action :configure_permitted_parameters, if: :devise_controller?

  # def current_user  
  #   @current_user ||= User.find(session['warden.user.user.key'][0][0]) if session['warden.user.user.key'][0][0]
  # end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :text])
  end
end
