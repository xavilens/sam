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
    get 'membership/delete/:member_id', action: :delete_view, controller: :members, as: :band_membership_delete
    get 'membership/delete/', action: :delete_view, controller: :members, as: :membership_delete

    resources :members, only: [:edit, :index]
    resources :images, only: [:show, :index]
    resources :events
    # resources :events, only: [:show, :index]

    # resources :posts do
    #   resources :comments
    # end
    # resources :ads
    # resources :salas_review
    # resources :rehearsal_studio_review
  end

  resources :messages
  resources :events do
    resources :event_participants, only: [:new, :create, :destroy]
  end
  resources :bands, only: :index
  resources :musicians, only: :index

  resources :members, only: [:create, :new, :edit, :update, :destroy]
  post '/members/send', action: :send_request_message, controller: :members
  post '/members/new', action: :new, controller: :members
  patch '/members/delete/', action: :delete_member, controller: :members, as: :members_delete

  resources :images, only: [:new, :create, :edit, :update, :destroy]

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
