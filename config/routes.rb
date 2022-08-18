Rails.application.routes.draw do
  resources :waitlist_users
  resource :pricing
  resource :checkout

  resources :webhooks do
    collection do
      post ':source', to: 'webhooks#create'
    end
  end

  # Authentication
  devise_for :users
  resources :you_tube_connections do
    collection do
      get :callback
    end
  end
  get 'auth/twitter2/callback', to: 'twitter_connections#create'
  resources :twitter_connections, only: [:show]

  # Application
  resource :dashboard
  resources :sources
  resources :you_tube_channels
  resources :you_tube_videos
  resources :suggestions
  resources :training_samples
  resources :tweets
  resource :billing

  # Marketing
  ['about', 'privacy', 'terms', 'contact'].each do |page|
    get page, to: "pages##{page}"
  end

  root "pages#root"
end
