Rails.application.routes.draw do

  devise_for :users

  root to: "events#index"
  resources :groups do
    resources :group_participants
    resources :events
  end
  resources :events, only: [:index] do
    resources :event_participants, as: 'participants' 
  end

    resources :chatrooms, only: :show do
      resources :messages, only: :create
    end
  end
  resources :users, only: [] do
    resources :workout_preferences
    post 'generate_workout_plan', to: 'workout_preferences#generate_workout_plan'

  end
end
