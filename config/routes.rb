Rails.application.routes.draw do
  devise_for :users,
  controllers: {
   sessions: 'users/sessions',
   registrations: 'users/registrations' ,
   omniauth_callbacks: 'users/omniauth_callbacks'}
   
   resources :cards, only:[:index, :new, :create, :show] do
    collection do
      post 'create', to: 'cards#create'
      post 'pay', to: 'cards#pay'
     end
   end
 
   resources :purchases, only: [:index] do
     collection do
       get 'index', to: 'purchases#index'
       post 'pay', to: 'purchases#pay'
       get 'done', to: 'purchases#done'
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
  resources :products, only:[:index, :new, :show] do
    resources :comments, only:[:create, :show]
  end

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