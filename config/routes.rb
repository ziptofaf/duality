Duality::Application.routes.draw do
  #this thing needs to be cleaned up :O
  get 'connection/main'
  get 'connection/walkthrough_pc'
  get 'connection/walkthrough_mac'
  get 'connection/walkthrough_linux'
  get 'connection/client'
  get 'footer/what_is_vpn'
  get 'footer/contact_us'
  get 'footer/vpn_vs_proxy'
  get 'footer/legals'
  match "profile", to: "profile#general", via: 'get'
  match "profile/change", to: "profile#change", via: 'get'
  match "profile/update", to: "profile#update", via: 'post'
  get "profile/payments"
  get "profile/vpns"
  get "support/forgot_password"
  get "support/password_reset_confirm"
  post "support/password_reset"
  match 'store', to: 'store#index', via: 'get'
  get "store/:id" => "store#view"
  resources :products
  get "profile/activity"
  match "api/client_side", to: 'api#client_side', via: 'post', :defaults => { :format => 'json' }
  match "api/server_side", to: 'api#server_side', via: 'post', :defaults => { :format => 'json' }
  match "api/check_ip", to: 'api#check_ip', via: 'get', :defaults => { :format => 'json' }
  match "api/disconnect", to: 'api#disconnect', via: 'post', :defaults => { :format => 'json'}
  match "api/connect", to: 'api#connect', via: 'post', :defaults => { :format => 'json'}
  get "wallet/add_funds"
  get "wallet/check_history"
  match '/wallet/add_funds', to: 'wallet#create', via: 'post'
  match '/signup', to: 'signup#new', via: 'get'
  get 'signup/new'
  match '/signup', to: 'signup#create', via: 'post'
  resources :accounts
  resources :servers
  resources :users
  get "static/faq"
  root 'static#index'
  resources :sessions, only: [:new, :create]
  match '/login', to: 'sessions#new', via: 'get'
  match '/login', to: 'sessions#create', via: 'post'
  match '/logout', to: 'sessions#destroy', via: 'get'
 namespace :processors do
  match '/listen/dogecoin', to: 'dogecoin#listen', via: 'post'
  match '/listen/bitcoin', to: 'bitcoin#listen', via: 'post'
  match '/listen/paypal', to: 'paypal#listen', via: 'post'
  resources :dogecoin, only: [:index]
  resources :bitcoin, only: [:index]
  resources :paypal, only: [:index]
 end
 namespace :product_processors do
  get "vpn_new/:id" => "vpn#new"
  match 'buy_vpn', to: "vpn#create", via: 'post'
  get "vpn/extend/:id" => "vpn#update"
  get 'vpn/details/:id' => "vpn#details"
  match "vpn/extend", to: "vpn#extend_account", via: 'post'
  post "vpn/sendZip"
 end
 get 'errors/routing'
match '*a', :to => 'errors#routing', via: [:get, :post] #custom page not found controller.

end
