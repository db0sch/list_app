Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :collections do
    resources :resources do
      resources :comments, only: [:create, :update, :destroy]
      member do
        put "like", to: "resources#upvote"
        put "dislike", to: "resources#downvote"
      end
    end
    member do
      put "like", to: "collections#like"
    end
    resources :comments, only: [:create, :update, :destroy]
  end
end
