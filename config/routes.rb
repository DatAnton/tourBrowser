Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#profile'
  get 'tours/get_regions', to: 'tours#get_regions'
  get 'tours/get_locations_by_region', to: 'tours#get_locations_by_region'
  
  resources :tours

  get 'users/profile', to: 'users#profile', as: :user_profile

end
