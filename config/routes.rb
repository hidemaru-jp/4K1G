Rails.application.routes.draw do

  # ユーザー用(パスワード機能除外)
  # URL /customers/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用（管理者登録・パスワード機能除外）
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "public/homes#top"
  get '/about' => 'public/homes#about', as: 'about'
  scope module: :public do
    post 'guests/guest_sign_in', to: 'guests#new_guest'
    resources :users do
      get '/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
      patch '/withdraw' => 'users#withdraw', as: 'withdraw'
      member do
        get :follows, :followers, :favorites
      end
     resource :relationships, only: [:create, :destroy]
    end
    resources :posts do
      resources :post_comments
      resource :favorites, only: [:create, :destroy]
    end
    resources :notifications, only: [:index] do
      collection do
         delete 'destroy_all'
      end
    end
  end

  namespace :admin do
    resources :users
    resources :posts do
      resources :post_comments
    end

  end




end
