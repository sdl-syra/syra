Syra::Application.routes.draw do
  resources :comments

  resources :articles

  resources :badges

  resources :reports

  resources :activities

  resources :notifications

  get "password_resets/new"
  get "pages/accueil"
  #devise_for :users
  get "sessions/new"
  resources :addresses

  resources :categories

  resources :hobbies

  resources :evaluations

  resources :propositions

  resources :opinions

  resources :levels

  resources :users

  resources :sessions, :only => [:new, :create, :destroy]
  
  resources :messages, :only => [:create]
  
  resources :password_resets
  
  resources :services do
    collection do
      get '/search', :to => 'services#index', :as => :index
    end
  end

  post '/set_geolocation' => 'services#set_geolocation'

  get '/auth/:provider/callback' => 'authentifications#create'

  get '/signup',  :to => 'users#new'
  get '/signin',  :to => 'sessions#new'

  delete '/signout', :to => 'sessions#destroy'

  get '/administrator/services',  :to => 'services#admin'
  get '/administrator/users',  :to => 'users#admin'
  get '/administrator/propositions',  :to => 'propositions#admin'
  get '/administrator/criminals',  :to => 'users#criminals'
  get '/administrator', :to => 'pages#administrator'

  get '/create_service', :to => 'services#new'
  get '/recherche', :to=> 'services#index'

  get '/users/:id/show_services', :to => 'users#show_services' , :as => 'show_services'
  get '/users/:id/show_propositions', :to => 'users#show_propositions' , :as => 'show_propositions'

  post '/users/:id/update_hobbies', :to => 'users#update_hobbies', :as => 'update_hobbies'
  post '/users/:id/update_address', :to => 'users#update_address', :as => 'update_address'
  post '/hobbies/:id/toggle_inscription', :to => 'hobbies#toggle_inscription', :as => 'toggle_inscription'

  post '/users/:id/upload_avatar' , :to => 'users#upload_avatar'
  
  post '/users/:id/unlock_badge', :to => 'users#unlock_badge', :as => 'unlock_badge'

  get '/users/:id/follow', :to => 'users#follow', :as => 'follow_user'
  get '/followers/favor', :to => 'users#favor', :as => 'favor_user'
  get '/users/:id/unfollow', :to => 'users#unfollow', :as => 'unfollow_user'
  get '/followers', :to => 'users#followers', :as => 'followers'
  get '/followed', :to => 'users#followed', :as => 'followed'
  get '/services/:id/accepterProp', :to => 'services#accepterProp', :as => 'accepter_prop_service'
  get '/services/:id/refuserProp', :to => 'services#refuserProp', :as => 'refuser_prop_service'
  get '/services/:id/nouvelleProp', :to => 'services#nouvelleProp', :as => 'nouvelle_prop_service'
  get '/services/:id/cloturer', :to => 'services#cloturer', :as => 'cloturer_service'
  get '/propositions/:id/validerEchange', :to => 'propositions#validerEchange', :as => 'valider_proposition'
  
  get '/all_conversations', :to => 'messages#all_conversations', :as => 'all_conversations'
  get '/messages/:id/show_conversation', :to => 'messages#show_conversation', :as => 'show_conversation'
  get '/messages/:id/more_msgs', :to => 'messages#more_msgs', :as => 'more_msgs'

  
  get '/get_notifs_header', :to => 'notifications#get_notifs_header', :as => 'get_notifs_header'

  get '/map', :to => 'pages#map'
  
  get '/market', :to => 'pages#market'
  
  get '/contact', :to => 'pages#contact'
  
  get '/administrator', :to => 'pages#administrator'
  
  get '/services_footer', :to => 'pages#services_footer'
  
  get '/test', :to => 'sessions#set_current_position'
  
  get '/delete_all_notifications', :to => 'notifications#deleteall'
  
  post '/all_notif_checked', :to => 'notifications#checkedall'
  
  get '/services/:id/resolveReports', :to => 'services#resolveReports', :as => 'resolve_reports'
  
  get '/header_search', :to => 'pages#header_search', :as => 'header_search'
  
  get "code/:id", :to => 'users#unlock_user'
  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

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
  root :to => "pages#accueil"
end
