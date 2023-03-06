Rails.application.routes.draw do
  root "articles#index" 
  get "/articles/:id/comments", to: "comments#index"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # get "/articles", to: "articles#index"
  # get "/articles/:id", to: "articles#show"
  # Defines the root path route ("/")
  # root "articles#index"
  resources :articles do
    resources :comments
  end
end
