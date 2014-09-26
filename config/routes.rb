Duality::Application.routes.draw do
  #resources - admin only available
  resources :special_accounts
  resources :products
  resources :accounts
  resources :servers
  resources :users
  #paymeny processors
  namespace :processors do
   match '/listen/dogecoin', to: 'dogecoin#listen', via: 'post'
   match '/listen/litecoin', to: 'litecoin#listen', via: 'post'
   match '/listen/bitcoin', to: 'bitcoin#listen', via: 'post'
   match '/listen/paypal', to: 'paypal#listen', via: 'post'
   resources :dogecoin, only: [:index]
   resources :bitcoin, only: [:index]
   resources :paypal, only: [:index]
   resources :litecoin, only: [:index]
  end
  #product_processors such as vpn
  namespace :product_processors do
   get "vpn_new/:id" => "vpn#new"
   match 'buy_vpn', to: "vpn#create", via: 'post'
   get "vpn/extend/:id" => "vpn#update"
   get 'vpn/details/:id' => "vpn#details"
   match "vpn/extend", to: "vpn#extend_account", via: 'post'
   post "vpn/sendZip"
  end
  #how to
  get 'connection/main'
  get 'connection/walkthrough_pc'
  get 'connection/walkthrough_mac'
  get 'connection/walkthrough_linux'
  get 'connection/walkthrough_ios'
  get 'connection/walkthrough_android'
  get 'connection/client'
  #footer
  get 'footer/what_is_vpn'
  get 'footer/contact_us'
  get 'footer/vpn_vs_proxy'
  get 'footer/legals'

  #daemon that checks server status
  get 'status/server'

  #api
  match "api/client_side", to: 'api#client_side', via: 'post', :defaults => { :format => 'json' }
  match "api/server_side", to: 'api#server_side', via: 'post', :defaults => { :format => 'json' }
  match "api/check_ip", to: 'api#check_ip', via: 'get', :defaults => { :format => 'json' }
  match "api/disconnect", to: 'api#disconnect', via: 'post', :defaults => { :format => 'json'}
  match "api/connect", to: 'api#connect', via: 'post', :defaults => { :format => 'json'}
  #profile
  match "profile", to: "profile#general", via: 'get'
  match "profile/change", to: "profile#change", via: 'get'
  match "profile/update", to: "profile#update", via: 'post'
  get "profile/payments"
  get "profile/vpns"
  get "profile/activity"

  #mobile in profile
  get 'mobile/view'
  post 'mobile/add'
  get 'mobile/check'

  #forgot password
  get "support/forgot_password"
  get "support/password_reset_confirm"
  post "support/password_reset"
  #store
  match 'store', to: 'store#index', via: 'get'
  get "store/:id" => "store#view"
  #wallet
  get "wallet/add_funds"
  get "wallet/check_history"
  match '/wallet/add_funds', to: 'wallet#create', via: 'post'
  #signup
  match '/signup', to: 'signup#new', via: 'get'
  get 'signup/new'
  match '/signup', to: 'signup#create', via: 'post'
  #login/logout/signin
  resources :sessions, only: [:new, :create]
  match '/login', to: 'sessions#new', via: 'get'
  match '/login', to: 'sessions#create', via: 'post'
  match '/logout', to: 'sessions#destroy', via: 'get'
  #completely static pages
  get "static/faq"
  root 'static#index'
  #error pages
 get 'errors/routing'
 match '*a', :to => 'errors#routing', via: [:get, :post] #custom page not found controller.

end
