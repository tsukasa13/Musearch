Rails.application.routes.draw do
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root 'homes#top'
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    resources :songs, only: [:index, :show]
    get 'users/mypage' => 'users#show'
    get 'users/information/edit' => 'users#edit'
    patch 'users/information' => 'users#update'
    get 'users/confirm_withdraw' => 'users#confirm_withdraw', as: 'confirm_withdraw'
    patch 'users/withdraw' => 'users#withdraw', as: 'withdraw'
    resources :posts, only: [:new, :create, :show, :edit, :update, :destroy]
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root 'homes#top'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
