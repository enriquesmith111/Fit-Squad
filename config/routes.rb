Rails.application.routes.draw do
  devise_for :users
  root to: "events#index"
  resources :groups do
    resources :group_participants
    resources :events
  end
  resources :events, only: [:index]
  
end
