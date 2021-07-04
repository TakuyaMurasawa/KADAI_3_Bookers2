Rails.application.routes.draw do

  devise_for :users
  root to: 'homes#top'

  get 'home/about' => 'homes#about'

  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:show, :edit, :update, :index] do
  resource :relationships, only: [:create, :destroy]
  # post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  # post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'following_user' => 'relationships#following_user'
  get 'follower_user' => 'relationships#follower_user'
  end
end
