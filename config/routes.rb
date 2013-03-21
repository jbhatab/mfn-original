Mfn::Application.routes.draw do


  match '/users/auth/:provider/callback' => 'authentications#create'

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}, controllers: {omniauth_callbacks: "omniauth_callbacks"}
                     
  match '/festival-list/:country/:year', :to => 'events#index'


  #for sessions and logging in
  #get "log_out" => "sessions#destroy", :as => "log_out"
  #get "log_in" => "sessions#new", :as => "log_in"
  #resources :sessions
  resources :authentications


  #show all the users rides and comments, this is good
  resources :users do
    resources :comments, :except => :new
    resources :rides
  end

  resources :festivals do
    collection {post :import} 
    resources :comments
    resources :reviews
  end

  resources :festival_years

  resources :events do
    resources :rides, :only => [:index, :show]
  end

  #calender routes  match '/calendar/new', :to => 'calendar#new'
  
  
  #calendar route
  match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}

  match '/festival-lineup', :to => 'users#lineup'

  match '/my-comments', :to => 'users#my-comments'


  post '/events/:id/:action' => 'users#add_to_festival_lineup'
  post '/events/:id/:action' => 'users#remove_from_festival_lineup'
  put '/comments/:id/:action' => 'comments#upvote'
  put '/comments/:id/:action' => 'comments#downvote'
  put '/reviews/:id/:action' => 'reviews#upvote'
  put '/reviews/:id/:action' => 'reviews#downvote'



  resources :homes

  match '/my-messages', :to => 'users#my-messages'
  match '/my-rides', :to => 'users#my-rides'
  match '/my-profile', :to => 'users#my-profile'
  match '/rideshare', :to => 'events#rideshare'
  match '/festival-map', :to => 'events#map'
  match '/about', :to => 'homes#about'
  match '/contact', :to => 'homes#contact'
  match '/rides_gmap', :to => 'rides#rides_gmap'

  root :to => 'homes#index'

  # match ‘/auth/facebook/callback’, :to => ‘profiless#failure’

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
