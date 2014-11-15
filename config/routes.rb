Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root(controller: "tickets", action: "index")

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  get("/callback", controller: "session", action: "callback")
  post("/callback", controller: "session", action: "callback")
  get("/logout", controller: "session", action: "destroy",as: :logout)
  get("/auth/failure", controller: "session", action: "failure")
  
  get("/mytickets", controller: "user", action: "myticket")
  get("/tag_watch", controller: "user", action: "watch_tag")
  put("/update", controller: "user", action: "update")

  get("/tickets_bot/:id", controller: "tickets_bot", action: "show")

  post("/tweet/update", controller: "tweet", action: "update")

  resources(:tickets) do
    member do
    end

    collection do
      get("search")
    end
  end
  
  
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
end
