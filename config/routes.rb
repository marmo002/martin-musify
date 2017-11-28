Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root "genres#index"
post "events/location"
get "venues/location"
resources :events, only: [:index, :show]
resources :venues, only: [:index, :show]
resources :artists, only: [:show]
resources :genres, only: [:index, :show]
resources :abouts, only: [:index]

end
