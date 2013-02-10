Mfn::Application.routes.draw do

  get "comments/index"

  #for sessions and logging in
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  resources :sessions

  resources :users do
    resources :comments, :only => [:index, :create, :destroy]
  end

  resources :festivals do
    resources :comments, :only => [:index, :create, :destroy]
  end
  get "sign_up" => "users#new", :as => "sign_up"

  #calender routes
  match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}
  match '/calendar/new', :to => 'calendar#new'
  match '/events', :to => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}

  #match '/auth/:provider/callback', :to => 'sessions#omni'  

  resources :festivals
  resources :events


  match '/lineup', :to => 'users#lineup'

  match '/my-comments', :to => 'comments#index'

  post '/festivals/:id' => 'users#line'

  resources :homes

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
