Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  root 'users#profile'
  get 'tours/get_regions', to: 'tours#get_regions'
  get 'tours/get_locations_by_region', to: 'tours#get_locations_by_region'
  get 'tours/saved_tours', to: 'tours#saved_tours', as: :saved_tours

  get 'users/profile', to: 'users#profile', as: :user_profile
  get 'users/index_for_hotels', to: 'users#index_for_hotels'
  get 'users/:id', to: 'users#show', as: :user_show
  get 'users/:id/tours', to: 'users#tours'
  delete 'users/destroy', to: 'users#destroy', as: :user_destroy

  resources :tours do
    resources :comments
    resources :images, only: [:destroy]
  end

  resources :plans do
    resources :plan_points
  end

  delete 'tours_and_users/delete', to: 'tours_and_users#delete'
  resources :tours_and_users, only: [:create, :index]

end
