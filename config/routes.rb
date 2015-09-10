Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'welcome#sign_in_or_up'

  get '/log_in', to: 'credentials#log_in'  

  post '/sign_up', to: 'users#create'

  get '/wall_request', to: 'wall#send_wall'

  post '/foe_request', to: 'wall#foe_request'

  post '/foe_response', to: 'wall#foe_response'

  post '/challenge', to: 'games#challenge'

  get '/resume', to: 'games#resume'

  get '/situation_request', to: 'games#send_situation'

  post '/send_situation_to_server', to: 'games#write_situation'

  get  '/check_for_move', to: 'games#check_for_move' 

  get '/resume_simultaneous_game', to: 'games#resume_simultaneous_game'

  post '/logout', to: 'wall#logout'

  get '/rankings_request', to: 'rankings#rankings_request'

  patch '/avatar_update', to: 'users#avatar_update' 
  

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
