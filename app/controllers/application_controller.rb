class ApplicationController < ActionController::Base
  #  CSRF отключён 
  protect_from_forgery with: :null_session

  #helper_method :current_user, :logged_in?

  before_action :configure_permitted_parameters, if: :devise_controller?

  #def current_user
    # IDOR + подмена пользователя
   # User.find_by(id: session[:user_id])
  #end

  #def logged_in?
  #  !!current_user
  #end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :age])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :age])
  end
end
