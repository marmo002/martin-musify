Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root "genres#index"

get "venues/location"
get "genres/location"
post "events/location"
get 'profile' => 'users#profile', :as => :profile


resources :events, except: :destroy
resources :venues, only: [:index, :show]
resources :artists, only: [:show]
resources :genres, only: [:index, :show]
resources :abouts, only: [:index]
resources :users, only: [:new, :create, :edit, :update]
get 'login' => 'user_sessions#new', :as => :login
delete 'logout' => 'user_sessions#destroy', :as => :logout
resources :user_sessions, only: [:create]

end
