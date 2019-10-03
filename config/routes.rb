Rails.application.routes.draw do
  devise_for :users
  get :cards, to: 'cards#new'
  
  devise_scope :user do 
    get 'users/sign_up/address' => 'devise/registrations#address'
    get 'users/sign_up/complete' => 'devise/registrations#complete'
    get 'users/sign_up/index' => 'devise/registrations#index'
    get 'users/sign_up/phone' => 'devise/registrations#phone'
  end

  root 'products#index'
  resources :users
  resources :user_addresses, only:[:index, :create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get 'users' => 'users#index'
end