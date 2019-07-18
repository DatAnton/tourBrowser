Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#profile'
  devise_for :users
  get 'tours/get_regions', to: 'tours#get_regions'
  get 'tours/get_locations_by_region', to: 'tours#get_locations_by_region'

  get 'users/profile', to: 'users#profile', as: :user_profile

  resources :tours do
    resources :comments
  end

end
