Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root "genres#index"

get "venues/location"
get "genres/location"
post "events/location"


resources :events, except: :destroy
resources :venues, only: [:index, :show]
resources :artists, only: [:show]
resources :genres, only: [:index, :show] do
  post :favourite, on: :member
  delete :unfavourite, on: :member
end
resources :abouts, only: [:index]
resources :users, only: [:new, :create, :edit, :update, :show]
get 'login' => 'user_sessions#new', :as => :login
delete 'logout' => 'user_sessions#destroy', :as => :logout
resources :user_sessions, only: [:create]

end
