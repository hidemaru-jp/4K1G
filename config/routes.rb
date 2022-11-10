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
  get '/about' => "public/homes#about", as: "about"

  scope module: :public do
     post 'guests/guest_sign_in', to: 'guests#new_guest'
    resources :users do
      member do
        get :follows, :followers
      end
     resource :relationships, only: [:create, :destroy]
    end
    resources :posts do
      resources :post_comments
      resource :favorites, only: [:create, :destroy]
    end
  end


end
