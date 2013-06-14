SoundcloudTwitter::Application.routes.draw do
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/playlist' => 'searches#playlist', :as => :playlist
  get '/link_twitter' => 'sessions#link_twitter', :as => :link_twitter
  get '/twitter' => 'twitter#stream', :as => :stream
  get '/signin' => 'pages#sign_in', :as => :sign_in
  root :to => 'pages#index'
end
