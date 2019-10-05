Rails.application.routes.draw do

  root 'products#index'
  get 'users' => 'users#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get 'users' => 'users#index'

end
