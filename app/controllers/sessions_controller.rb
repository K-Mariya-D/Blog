class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email], password: params[:password])
    session[:user_id] = user.id if user
    redirect_to posts_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
