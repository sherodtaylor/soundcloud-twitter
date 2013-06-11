class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]

    unless User.omniauth_find(auth) == nil
      @user = User.omniauth_find(auth)
    end

    if auth['provider'] == "twitter"
      link_twitter(auth)
    elsif @user != nil
      session[:user_id] = @user.id
      redirect_to root_url
    elsif
      created_user = User.omniauth_create(auth)
      session[:user_id] = created_user.id
      redirect_to root_url
    end
  end

  def link_twitter(auth)
    user = User.find(session[:user_id])
    user.twitter_token = auth['credentials']['token']
    user.twitter_id = auth['extra']['raw_info']['id']
    user.save!
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
