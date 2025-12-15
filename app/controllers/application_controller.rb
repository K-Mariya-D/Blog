class ApplicationController < ActionController::Base
  #  CSRF отключён 
  protect_from_forgery with: :null_session

  helper_method :current_user, :logged_in?


  def current_user
    # IDOR + подмена пользователя
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end
end
