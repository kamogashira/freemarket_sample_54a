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
 
   resources :purchases do
     collection do
       get 'index', to: 'purchases#index'
       get 'cards', to: 'purchases#cards'
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
    get 'users/sign_up/step' => 'users/registrations#step'
    post 'users/sign_up/register' => 'users/registrations#register'
  end

  root 'products#index'

  resources :products, only:[:index, :new, :create, :show, :edit, :update] do
    resources :comments, only:[:create, :show]

    #product_idに紐づく商品表示に関するルート作成

    member do
      get 'show_my_product'
    end

    #Ajaxで動くカテゴリー選択アクションのルートを作成
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'get_size', defaults: { format: 'json' }
    end

  end

  resources :users, only:[:index, :update] do
    collection do
      get 'logout'
      post 'logout'
      get 'selling'
      get 'trading'
      get 'completed'
    end

    member do
      get 'profile'
    end
    resources :user_addresses, only:[:new, :create, :update]
    resources :delivery_addresses, only:[:new, :create, :update]

  end



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get 'users' => 'users#index'
end