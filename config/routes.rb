Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :groups do
    resources :group_participants
    resources :events
  end
end
