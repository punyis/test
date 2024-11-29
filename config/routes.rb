Rails.application.routes.draw do
  # Authentication routes for Devise
  devise_for :users
  

  # Post routes with nested comments and likes/unlikes
  resources :posts do
    resources :comments, only: [:create] # Nested route for creating comments
    
    member do
      post 'like', to: 'likes#create'     # Route for liking a post
      delete 'unlike', to: 'likes#destroy' # Route for unliking a post
    end
  end

  # Root path
  root "posts#index"
end
