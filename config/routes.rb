Rails.application.routes.draw do
  get 'event_participants/new'

  get 'event_participants/create'

  get 'event_participants/show'

  get 'event_participants/destroy'

  get 'event_participants/send_request'

  get 'event_participants/send_request_message'

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
  end

  resources :bands, only: :index
  resources :musicians, only: :index
  resources :messages

  resources :members, only: [:create, :new, :edit, :update, :destroy]
  post '/members/send', action: :send_request_message, controller: :members
  post '/members/new', action: :new, controller: :members
  patch '/members/delete/', action: :delete_member, controller: :members, as: :members_delete

  resources :images, only: [:new, :create, :edit, :update, :destroy]

  resources :events do
    resources :participants, only: [:show], controller: :event_participants

    collection do
      get "participants/request", action: :participant_request, controller: :event_participants, as: :participant_request
      post "participants/send", action: :send_request, controller: :event_participants, as: :send_participant_request
    end
  end

  resources :participants, only: [:new, :create, :destroy], controller: :event_participants
end
