Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: "home#index"

  resources :groups do
    resources :posts

    member do
      post :join
      post :remove_member
    end
  end 
end
