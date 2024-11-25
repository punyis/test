Rails.application.routes.draw do
  devise_for :users

  resources :posts do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
    member do
      post 'like', to: 'likes#create'    # ใช้ post สำหรับ Like
      delete 'unlike', to: 'likes#destroy' # ใช้ delete สำหรับ Unlike
    end
  end

  # เส้นทางสำหรับลบโพสต์
  resources :posts, only: [:destroy]

  root "posts#index"
end
