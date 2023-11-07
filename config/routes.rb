Rails.application.routes.draw do
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root 'homes#top'
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    resources :songs, only: [:new, :create, :index, :show] do
      collection do
        get 'search'
      end
    end
    get 'users/mypage' => 'users#show'
    get 'users/information/edit' => 'users#edit'
    patch 'users/information' => 'users#update'
    get 'users/confirm_withdraw' => 'users#confirm_withdraw', as: 'confirm_withdraw'
    patch 'users/withdraw' => 'users#withdraw', as: 'withdraw'
    resources :posts, only: [:show, :edit, :update, :destroy]
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root 'homes#top'
    resources :songs, only:[:index, :show]
    resources :users, only:[:index, :show, :edit, :update]
    resources :posts, only:[:show, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
