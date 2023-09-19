Rails.application.routes.draw do
  devise_for :users

  root to: "events#index"
  get 'my_groups', to: 'groups#my_groups', as: :my_groups

  resources :groups do
    resources :group_participants
    resources :events
  end

  resources :events, only: [:index, :show] do
    collection do
      get 'search'
    end
    resources :event_participants, as: 'participants'
    post 'events/:event_id/event_participants', to: 'event_participants#create', as: 'event_event_participants'
    delete '/events/:event_id/event_participants/:id', to: 'event_participants#destroy'
    resources :chatrooms, only: :show do
      resources :messages, only: :create
    end
  end

  get 'about', to: 'pages#about'
  get 'terms-and-conditions', to: 'pages#tandc'
  get 'privacy-policy', to: 'pages#private'
  get 'contact-us', to: 'pages#contact'
  get 'cookies-policy', to: 'pages#cookies'



  resources :users, only: [] do
    resources :workout_preferences
    post 'generate_workout_plan', to: 'workout_preferences#generate_workout_plan'
  end
end
