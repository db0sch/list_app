Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :collections do
    resources :resources do
      member do
        put "like", to: "resources#upvote"
        put "dislike", to: "resources#downvote"
      end
    end
    member do
      put "like", to: "collections#like"
    end
  end
end
