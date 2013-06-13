class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end
  def is_connected?
    if current_user.nil?
      false
    elsif current_user.twitter_connect == true
      true
    end
  end

  def signed_in?
    !!current_user
  end
  helper_method :current_user, :signed_in?, :is_connected?

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.nil? ? user : user.id
  end
end
