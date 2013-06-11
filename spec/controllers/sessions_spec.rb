require 'spec_helper'

describe SessionsController do
  before do
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:soundcloud]
    @auth = request.env['omniauth.auth']
  end

  describe '#linktwitter' do
    it 'should link accounts' do
      user = User.create(name: "Sherod Taylor",
                         soundcloud_token: "23fc3g345G"
                         )
      session[:user_id] = user.id

      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
      get :create, :provider => 'twitter'
      token = User.first.twitter_token
      expect(token).to eq "123-321"
    end
  end

  describe '#create' do
    it "should sign_in with soundcloud if user is found" do
      user = User.create(name: "Sherod Taylor",
                  soundcloud_token: @auth['credentials']['token']
                 )
      get :create, :provider => 'soundcloud'
      assigns(:user).should eq user
    end
    it 'should it should assign a user if user not found' do
      get :create, :provider => 'soundcloud'
      expect(session[:user_id]).to eq 1
    end

    it "should create a user if none found" do
      get :create, :provider => 'soundcloud'
      expect(User.first).to_not be_nil
    end
  end


  describe '#destroy' do
    it "should set session to nil" do
      session[:user_id] = 1
      get :destroy
      expect(session[:user_id]).to be_nil
    end
  end
end
