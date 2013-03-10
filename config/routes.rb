Mfn::Application.routes.draw do



  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
                     controllers: {omniauth_callbacks: "omniauth_callbacks"}
                     

  #facebook login routes
  #match 'auth/facebook/callback', to: 'sessions#create'
  #match 'auth/failure', to: redirect('/')
  #match 'signout', to: 'sessions#destroy', as: 'signout'



  #for sessions and logging in
  #get "log_out" => "sessions#destroy", :as => "log_out"
  #get "log_in" => "sessions#new", :as => "log_in"
  #resources :sessions

  resources :users do
    resources :comments, :except => :new
    resources :rides
  end

  resources :festivals do
    collection {post :import}
    resources :comments
    resources :rides, :only => [:index, :show]
  end

  #calender routes  match '/calendar/new', :to => 'calendar#new'
  match '/events', :to => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}
  match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}
  #match '/auth/:provider/callback', :to => 'sessions#omni'  

  resources :events

  match '/lineup', :to => 'users#lineup'

  match '/my-comments', :to => 'users#my-comments'
  
  post '/festivals/:id/:action' => 'users#line'
  post '/festivals/:id/:action' => 'users#remove_line'
  put '/comments/:id/:action' => 'comments#upvote'
  put '/comments/:id/:action' => 'comments#downvote'



  resources :homes

  match '/rideshare', :to => 'festivals#rideshare'
  match '/festival-map', :to => 'festivals#map'
  match '/about', :to => 'homes#about'
  match '/contact', :to => 'homes#contact'

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
