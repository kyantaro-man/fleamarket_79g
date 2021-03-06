Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations' 
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
    get 'cards', to: 'users/registrations#new_card'
    post 'cards', to: 'users/registrations#create_card'
  end
  
  root 'tops#index'  #rootをitemsからtopsに変更
  
  resources :items, only: [:index, :new, :create, :edit, :update, :show, :destroy] do
    member do
      post 'purchase'
      get 'purchased'
      get 'buy'
    end
    resources :comments, only: :create
  end

  resources :users, only: :show do       #マイページへのルーティング
    member do
      get 'logout'                       #ログアウト画面へのルーティング
      get 'payment'                      #支払い方法画面へのルーティング
    end

    resources :cards, only: [:index, :new, :create, :destroy]

  end
  resources :categories, only: [:index, :show, :new]      #カテゴリ一覧表示
  # rails.org/routing.html
end
