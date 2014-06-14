StompFish::Application.routes.draw do
  # Artists
  get "artists/:id" => "artists#show"
  get "artists" => "artists#index"
  
  # Albums
  get "albums/:id" => "albums#show"
  get "albums" => "albums#index"

  # Songs
  get "songs/:id" => "songs#show"
  get "songs" => "songs#index"

  # Playlists
  resources :playlists, except: [:new, :edit]

  # Playlist Songs
  post "playlists/:playlist_id/songs/:id" => "playlist_songs#create"
  put "playlists/:playlist_id/songs" => "playlist_songs#update"
  delete "playlists/:playlist_id/songs/:id" => "playlist_songs#destroy"

  match "*path", to: "errors#routing", via: :all

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
