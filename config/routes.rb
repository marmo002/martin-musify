Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root "events#index"
resources :events, only: [:index, :show]
resources :venues, only: [:index, :show]
resources :artists, only: [:show]
resources :genres, only: [:index, :show]


end
