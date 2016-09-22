Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :collections do
    resources :resources do
      # cf. polymorphic routes
      resources :comments, only: [:create, :update, :destroy]
      member do
        put "like", to: "resources#upvote"
        put "dislike", to: "resources#downvote"
      end
    end
    member do
      put "like", to: "collections#like"
      put "follow", to: "collections#follow"
    end
    # cf. polymorphic routes
    resources :comments, only: [:create, :update, :destroy]
  end

  resources :activities, only: :index

  resources :users, only: [:show] do
    member do
      put "follow", to: "users#follow"
    end
  end
end
