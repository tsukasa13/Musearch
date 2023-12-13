Rails.application.routes.draw do
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_scope :user do
    post 'users/guest_sign_in' => 'public/sessions#guest_sign_in'
  end
  scope module: :public do
    root 'homes#top'
    resources :songs, only: [:new, :create, :index, :show] do
      collection do
        get 'search_with_songs' => "songs#search"
        get 'search_with_posts' => "posts#search"
        get 'genre'
      end
      resources :posts, only: [:create, :show, :edit, :update, :destroy] do
        # collection do
        #   get 'search'
        # end
        resources :comments, only: [:create, :destroy]
        resource :like, only: [:create, :destroy]
      end
    end
    get 'users/mypage' => 'users#show'
    get 'users/:id/likes' => 'users#like', as: 'like'
    get 'users/information/edit' => 'users#edit'
    patch 'users/information' => 'users#update'
    get 'users/confirm_withdraw' => 'users#confirm_withdraw', as: 'confirm_withdraw'
    patch 'users/withdraw' => 'users#withdraw', as: 'withdraw'
    # resources :posts, only: [:create, :show, :edit, :update, :destroy] do
    #   collection do
    #     get 'search'
    #   end
    #   resources :comments, only: [:create, :destroy]
    #   resource :like, only: [:create, :destroy]
    # end
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root 'homes#top'
    resources :songs, only:[:index, :show] do
      collection do
        get 'search'
        get 'genre'
      end
    end
    resources :users, only:[:index, :show, :edit, :update]
    resources :posts, only:[:show, :destroy] do
      collection do
        get 'search'
      end
      resources :comments, only: [:create, :destroy]
      resource :like, only: [:create, :destroy]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
