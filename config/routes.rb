Rails.application.routes.draw do
  devise_for :users
  resources :cards, only:[:index, :new, :create]
  
  devise_scope :user do 
    get 'users/sign_up/address' => 'devise/registrations#address'
    get 'users/sign_up/complete' => 'devise/registrations#complete'
    get 'users/sign_up/index' => 'devise/registrations#index'
    get 'users/sign_up/phone' => 'devise/registrations#phone'
  end

  root 'products#index'

  resources :users, action: :index
  resources :user_addresses, only:[:index, :create]

  resources "users",only: :logout, path: '' do
    collection do
      get 'logout'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get 'users' => 'users#index'
end