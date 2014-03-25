Syra::Application.routes.draw do
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

  resources :services do
    collection do
      get '/search', :to => 'services#index', :as => :index
    end
  end

  get '/auth/:provider/callback' => 'authentifications#create'

  get '/signup',  :to => 'users#new'
  get '/signin',  :to => 'sessions#new'

  delete '/signout', :to => 'sessions#destroy'

  get '/admin/services',  :to => 'services#admin'
  get '/admin/users',  :to => 'users#admin'

  get '/create_service', :to => 'services#new'
  get '/recherche', :to=> 'services#index'

  get '/users/:id/update_hobbies', :to => 'users#update_hobbies', :as => 'update_hobbies'

  post '/users/:id/upload_avatar' , :to => 'users#upload_avatar'

  get '/users/:id/follow', :to => 'users#follow', :as => 'follow_user'

  get '/map', :to => 'pages#map'
  
  get '/equipe', :to => 'pages#equipe'
  
  get '/contact', :to => 'pages#contact'
  
  get '/services_footer', :to => 'pages#services_footer'
  
  get '/test', :to => 'sessions#set_current_position'

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
