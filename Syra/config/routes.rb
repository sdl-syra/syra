Syra::Application.routes.draw do
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


  resources :successes

  resources :levels

  resources :users

  resources :sessions, :only => [:new, :create, :destroy]
  
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

  get '/users/:id/update_hobbies', :to => 'users#update_hobbies', :as => 'update_hobbies'

  post '/users/:id/upload_avatar' , :to => 'users#upload_avatar'

  get '/users/:id/follow', :to => 'users#follow', :as => 'follow_user'
  get '/users/:id/unfollow', :to => 'users#unfollow', :as => 'unfollow_user'
  get '/followers', :to => 'users#followers', :as => 'followers'
  get '/services/:id/accepterProp', :to => 'services#accepterProp', :as => 'accepter_prop_service'
  get '/services/:id/refuserProp', :to => 'services#refuserProp', :as => 'refuser_prop_service'
  get '/services/:id/nouvelleProp', :to => 'services#nouvelleProp', :as => 'nouvelle_prop_service'
  get '/services/:id/cloturer', :to => 'services#cloturer', :as => 'cloturer_service'
  get '/propositions/:id/validerEchange', :to => 'propositions#validerEchange', :as => 'valider_proposition'

  get '/map', :to => 'pages#map'
  
  get '/equipe', :to => 'pages#equipe'
  
  get '/contact', :to => 'pages#contact'
  
  get '/administrator', :to => 'pages#administrator'
  
  get '/services_footer', :to => 'pages#services_footer'
  
  get '/test', :to => 'sessions#set_current_position'
  
  get '/delete_all_notifications', :to => 'notifications#deleteall'
  
  post '/all_notif_checked', :to => 'notifications#checkedall'
  
  get '/services/:id/resolveReports', :to => 'services#resolveReports', :as => 'resolve_reports'
  

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
