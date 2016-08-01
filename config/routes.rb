Rails.application.routes.draw do


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'site#index'
  root 'site#index'

  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    omniauth: 'users/omniauth_callbacks',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks'
  }

  # get 'users/' => 'users#index'
  # get 'users/:id' => 'users#show', as: 'user'

  devise_for :delegated_users

  resources :users do
    resources :images
    resources :posts do
      resources :comments
    end
    resources :events
    resources :ads
    resources :salas_review
    resources :rehearsal_studio_review
  end

  # get 'users/edit/account' => 'users#edit', as: 'edit_user_account'

  resources :bands
  resources :musicians
  resources :events
  resources :salas
  resources :rehearsal_studio
  resources :posts do
    resources :comments
  end

  # get 'events/new'
  # get 'events/show'
  # get 'events/edit'
  # get 'events/update'

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
