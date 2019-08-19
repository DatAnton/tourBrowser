Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  root 'users#profile'
  get 'tours/get_regions', to: 'tours#get_regions'
  get 'tours/get_locations_by_region', to: 'tours#get_locations_by_region'
  get 'tours/saved_tours', to: 'tours#saved_tours', as: :saved_tours

  get 'users/profile', to: 'users#profile', as: :user_profile
  put 'users/edit_count_of_hotels', to: 'users#edit_count_of_hotels'
  get 'users/edit_users', to: 'users#edit_users', as: :edit_count_of_hotels
  get 'users/:id', to: 'users#show', as: :user_show
  get 'users/:id/tours', to: 'users#tours'
  delete 'users/destroy', to: 'users#destroy', as: :user_destroy

  resources :tours do
    resources :comments, only: [:index, :create]
    resources :images, only: [:destroy]
  end

  resources :plans do
    resources :plan_points, only: [:new, :create, :destroy]
  end

  delete 'tours_and_users/delete', to: 'tours_and_users#delete'
  get 'hotels/hotels_of_user', to: 'hotels#hotels_of_user', as: :hotels_of_user

  resources :tours_and_users, only: [:create, :index]

  resources :hotels

  get 'static_pages/about', to: 'static_pages#about', as: :about_page
  get 'static_pages/hotel_info', to: 'static_pages#hotel_info', as: :hotel_info

end
