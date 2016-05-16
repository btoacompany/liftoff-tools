Rails.application.routes.draw do
  root 'top#index'

  #for test
  get '/test' => 'tests#index'
    
  # product tools
  get	'/products'			=> 'products#top'
  get	'/products/list/:cat_id'	=> 'products#items_list'
  get	'/products/list/:cat_id/:item'	=> 'products#index'
  get	'/products/create'		=> 'products#create'
  post	'/products/create/specs'	=> 'products#create_specs'
  post	'/products/create/confirm'	=> 'products#create_confirm'
  post	'/products/create/action'	=> 'products#create_action'
  post	'/products/create/shops'	=> 'products#create_shops'

  get	'/products/:id/edit'		=> 'products#edit'
  post	'/products/edit/specs'		=> 'products#edit_specs'
  post	'/products/edit/confirm'	=> 'products#edit_confirm'
  post	'/products/edit/shops'		=> 'products#edit_shops'
  post	'/products/edit/action'		=> 'products#edit_action'	
  post	'/products/delete'		=> 'products#delete_action'
  
  # maker tools
  get	'/makers'			=> 'makers#index'
  get	'/makers/create'		=> 'makers#create'
  get	'/makers/:id/edit'		=> 'makers#edit'
  post	'/makers/create_action'		=> 'makers#create_action'
  post	'/makers/edit_action'		=> 'makers#edit_action'	
  post	'/makers/delete_action'		=> 'makers#delete_action'

  # shops tools
  get	'/shops'			=> 'shops#index'
  get	'/shops/create'			=> 'shops#create'
  get	'/shops/:id/edit'		=> 'shops#edit'
  post	'/shops/create_action'		=> 'shops#create_action'
  post	'/shops/edit_action'		=> 'shops#edit_action'	
  post	'/shops/delete_action'		=> 'shops#delete_action'

  # items tools
  get	'/items/'			=> 'items#index'
  get	'/items/create'			=> 'items#create'
  post	'/items/create/specs'		=> 'items#create_specs'
  post	'/items/create_action'		=> 'items#create_action'
  get	'/items/:id/edit'		=> 'items#edit'
  post	'/items/edit/specs'		=> 'items#edit_specs'
  post	'/items/edit_action'		=> 'items#edit_action'	
  post	'/items/delete_action'		=> 'items#delete_action'

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
