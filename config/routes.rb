Rails.application.routes.draw do
  
  root 'site#index'

  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    omniauth: 'users/omniauth_callbacks',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks'
  }

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

  resources :bands
  resources :musicians
  resources :events
  resources :salas
  resources :rehearsal_studio
  resources :posts do
    resources :comments
  end

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
