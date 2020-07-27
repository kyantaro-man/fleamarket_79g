Rails.application.routes.draw do
  devise_for :users, controllers: {
     registrations: 'users/registrations' 
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  root 'tops#index'  #rootをitemsからtopsに変更

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
