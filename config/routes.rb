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
    get 'edit/knowledges', action: :edit_knowledges, as: :edit_knowledges
    put :update_knowledges
    patch :update_knowledges

    get 'membership/send/:from_user', action: :send_request, controller: :members, as: :send_membership
    # get 'membership/new/', action: :send_request, controller: :members, as: :send_membership
    # get 'membership/send/', action: :send_membership, controller: :users, as: :send_membership
    put :add_member, controller: :users
    patch 'membership/delete/', action: :delete_membership, as: :delete_membership

    resources :images
    resources :events

    # resources :posts do
    #   resources :comments
    # end
    # resources :ads
    # resources :salas_review
    # resources :rehearsal_studio_review
  end

  post 'membership/add', action: :add, controller: :memberships


  resources :messages
  resources :events
  resources :bands, only: :index
  resources :musicians, only: :index
  resources :members

  # resources :salas
  # resources :rehearsal_studio
  # resources :posts do
  #   resources :comments
  # end

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
