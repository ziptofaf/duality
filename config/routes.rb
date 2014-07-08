Duality::Application.routes.draw do
  #get 'errors/routing'

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
  #match "api/client_side", to: 'api#client_side', via: 'get'
  match "api/client_side", to: 'api#client_side', via: 'post'
  match "api/server_side", to: 'api#server_side', via: 'post'
  get "wallet/add_funds"
  get "wallet/check_history"
  match '/wallet/add_funds', to: 'wallet#create', via: 'post'
  match '/signup', to: 'signup#new', via: 'get'
  match '/signup', to: 'signup#create', via: 'post'
  resources :accounts
  resources :servers
  resources :users
  get "static/faq"
  root 'static#index'
  resources :sessions, only: [:new, :create]
  match '/login', to: 'sessions#new', via: 'get'
  match '/logout', to: 'sessions#destroy', via: 'get' 
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
 namespace :processors do
  match '/listen/dogecoin', to: 'dogecoin#listen', via: 'get'
  match '/listen/bitcoin', to: 'bitcoin#listen', via: 'get'
  match '/listen/paypal', to: 'paypal#listen', via: 'post'
  resources :dogecoin, only: [:index]
  resources :bitcoin, only: [:index]
  resources :paypal, only: [:index]
 end
 namespace :product_processors do
  #match 'vpn_new', to: 'vpn#new', via: 'get'
  get "vpn_new/:id" => "vpn#new"
  match 'buy_vpn', to: "vpn#create", via: 'post' 
 end
  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
match '*a', :to => 'errors#routing', via: [:get, :post]

end
