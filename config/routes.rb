Rails.application.routes.draw do
  get 'posts/new'
  get 'posts/create'
  get 'posts/show'
  root to: "homes#index"
  devise_for :users

  resources :clients
  # resources :trainers
  resources :trainers do
    resources :posts
  end
  delete '/trainers/sign_out', to: 'devise/sessions#destroy', as: :trainers_sign_out
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
 
  # Defines the root path route ("/")
  # root "articles#index"
end
