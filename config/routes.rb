Rails.application.routes.draw do
 devise_for :users,
  controllers: {
   registrations: 'users/registrations' ,
   omniauth_callbacks: 'users/omniauth_callbacks'}
   
  resources :cards, only:[:index, :new, :create] do
    collection do
      post 'pay', to: 'card#pay'
    end
  end
  
  devise_scope :user do 
    get 'users/sign_up/SNS' => 'users/registrations#SNS'
    get 'users/sign_up/address' => 'users/registrations#address'
    get 'users/sign_up/complete' => 'users/registrations#complete'
    get 'users/sign_up/index' => 'users/registrations#index'
    get 'users/sign_up/phone' => 'users/registrations#phone'
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