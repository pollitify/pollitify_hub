Rails.application.routes.draw do
  
  #
  # BCG TODO ADD LOGIN REQUIREMENT FOR THIS
  #
  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"
  
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    passwords: "users/passwords",
    confirmations: "users/confirmations"
  }

  devise_scope :user do
    %w[profile me whoami].each do |route|
      get "user/#{route}", to: "users/registrations#show"
    end

    get "user/settings", to: "users/settings#index"
  end
  

  #
  # SOCIAL NETWORKING STUFF
  #
  resources :relationships, only: [:create, :destroy]
  resources :badges, only: [:index, :show]

  resources :posts do
    member do
      put :like, to: 'posts#upvote'
      put :dislike, to: 'posts#downvote'
    end
  end
  
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :following, :followers
    end
  end
  resources :users, only: [ :index, :new, :edit, :update, :show, :destroy ], constraints: { id: /\d+/ } do
    collection do
      post "/create" => "users#create"
    end
    
    member do
      get :following, :followers
    end
    
  end
  
  #
  # NON SOCIAL NETWORKING STUFF
  #
  resources :congressional_district_types
  resources :government_official_types
  resources :political_parties
  resources :google_sheet_urls
  resources :news_feed_urls
  resources :counties
  resources :cities
  resources :congressional_districts
  resources :events
  resources :event_types
  resources :states
  resources :organizations
  resources :secure_chat_systems
  resources :features
  resources :feature_categories
  resources :domains
  resources :setup
    
  get "government_officials/me", to: "government_officials#me"    
  resources :government_officials do
    collection do
      get 'me'
    end
  end
  
  resources :news_feed_items do
    member do
      post :upvote
      post :downvote
    end
    # member do
    #   #put 'upvote'
    #   #put 'downvote'
    #   post 'upvote'
    #   post 'downvote'
    # end
    # member do
    #   put "upvote", to: "news_feed_items#upvote"
    #   put "downvote", to: "news_feed_items#downvote"
    # end
    resources :comments, only: %i[create destroy]
  end
  
  %w[about contact faqs product_features changelog].each do |page|
    get page, to: "static_pages##{page}", as: page
  end
  

  
  get "suggest_event" => "home#suggest_event"
  get "suggest_event_google_sheet" => "home#suggest_event_google_sheet"
  get "suggest_event_mobilize_url" => "home#suggest_event_mobilize_url"
  get "suggest_event_paste_text" => "home#suggest_event_paste_text"
  get "suggest_event_upload_flier" => "home#suggest_event_upload_flier"
  get "suggest_event_form" => "home#suggest_event_form"

  get "search" => "search#index"
  
  post "set_location", to: "locations#set_location"
  

  get "home/index"
  get "landing/index"
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  #get "home#suggest"
  #root "home#index"
  root "landing#index"
end

  
  
  # devise_for :users
  # root 'posts#index'  # or whatever your current root is

  # resources :posts do
  #   member do
  #     put :like, to: 'posts#upvote'
  #     put :dislike, to: 'posts#downvote'
  #   end
  # end

  # Health check and other existing routes...
  #get "up" => "rails/health#show", as: :rails_health_check
  
  



  # get "badges/index"
  # get "badges/show"
  
  
  
  #resources :news_feed_items


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html



  

  
  # resources :news_feed_items do
  #   resources :votes, only: [:create]
  #   resources :comments, only: [:create, :destroy]
  # end



  
  # resources :users, only: [:index, :show, :edit, :update] do
  #   member do
  #     get :following, :followers
  #   end
  # end

  


  


  #end
