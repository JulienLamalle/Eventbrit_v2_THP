Rails.application.routes.draw do
  devise_for :users

  root 'events#index'

  resources :events
  resources :users,  only: [:show]
  resources :events do
    resources :attendances
    resources :charges
    resources :events_pictures, only: [:new, :create]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
