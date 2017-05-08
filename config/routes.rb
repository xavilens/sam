Rails.application.routes.draw do
  ######### CONCERNS
  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end
  concern :pageable do
    get '(page/:page)', on: :collection, as: ''
  end

  ######### ROUTES
  root 'site#index'

  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    omniauth: 'users/omniauth_callbacks',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks'
  }

  ## USERS
  resources :users, concerns: :paginatable do
    ## USER EDIT INFO
    get 'edit/knowledges', action: :edit, controller: :musicians, as: :edit_knowledges

    ## USER MEMBERSHIPS
    resource :membership, only:[], controller: :members do
      get 'send/:from_user', action: :send_request, controller: :members, as: :send
      get 'delete/:member_id', action: :delete_view, controller: :members, as: :band_delete
      get 'delete/', action: :delete_view, controller: :members
    end
    # get 'membership/send/:from_user', action: :send_request, controller: :members, as: :send
    # get 'membership/delete/:member_id', action: :delete_view, controller: :members, as: :band_delete
    # get 'membership/delete/', action: :delete_view, controller: :members

    resources :members, only: [:edit, :index]

    ## USER EVENTS
    resources :events, only: [:show, :index], concerns: :paginatable

    ## USER MEDIA
    resources :songs, only: [:index], concerns: :paginatable
    resources :videos, only: [:index], concerns: :paginatable
    resources :images, only: [:show, :index], concerns: :paginatable

    ## USER FOLLOWSHIPS
    get 'leaders(/page/:page)', action: :leaders, controller: :followships, as: :leaders
    get 'followers(/page/:page)', action: :followers, controller: :followships, as: :followers
  end

  ## BANDS, MUSICIANS, MESSAGES
  resources :bands, only: :index, concerns: :paginatable
  resources :musicians, only: [:index, :update], concerns: :paginatable
  resources :messages, concerns: :paginatable do
    collection do
      get "inbox(/page/:page)", action: :inbox, as: :inbox
      get "outbox(/page/:page)", action: :outbox, as: :outbox
      get "memberships(/page/:page)", action: :memberships, as: :memberships
      get "participants(/page/:page)", action: :participants, as: :participants
      get "search(/page/:page)", action: :search, as: :search
    end
  end

  ## MEMBERS
  resources :members, only: [:create, :edit, :update, :destroy] do
    post 'send', action: :send_request_message, controller: :members
    post 'new', action: :new, controller: :member
  end

  ## EVENTS
  resources :events do
    get :delete, action: :destroy_view, controller: :events
    get "participants/:id/delete", action: :destroy_view, controller: :event_participants, as: :participant_destroy
    collection do
      get "participants/request", action: :participant_request, controller: :event_participants, as: :participant_request
      post "participants/send", action: :send_request, controller: :event_participants, as: :send_participant_request
    end
  end

  ## EVENT PARTICIPANTS
  resources :participants, only: [:new, :create, :destroy], controller: :event_participants

  ## MEDIAS
  resources :images, only: [:new, :create, :edit, :update, :destroy]
  resources :songs, only: [:new, :create, :edit, :update, :destroy]
  resources :videos, only: [:new, :create, :edit, :update, :destroy]

  ## FOLLOWSHIPS
  namespace :followships do
    post ":user_id", action: :create
    delete ":user_id", action: :destroy
  end
end
