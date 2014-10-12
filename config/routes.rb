Rails.application.routes.draw do

  resources :visitors, defaults: { format: 'js' }, only: [:index, :create, :update, :destroy, :show]
  get 'store/:store_id/duration' => 'visitors#length_by_store', defaults: {format: 'js'}
  get 'store/:store_id/count' => 'visitors#people_count_by_store', defaulst: {format: 'js'}
  get 'store/:store_id/current_count' => 'visitors#current_count_by_store', defaults: {format: 'js'}
  get 'visitor/first_time' => 'visitors#first_time', defaults: {format: 'js'}
  get 'visitor/all_duration' => 'visitors#all_lengths', defaults: {format: 'js'}
  
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
end
