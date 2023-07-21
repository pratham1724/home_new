Rails.application.routes.draw do
  root to: "homes#index"
  get 'appointments/new'
  get 'appointments/create'
  get 'posts/new'
  get 'posts/create'
  get 'posts/show'
  
  devise_for :users

  resources :clients
  # resources :trainers
  resources :trainers do
    resources :posts
    resources :appointments, only: [:new, :create]
  end

  # resources :trainers do
    
  # end

  resources :appointments, only: [] do
    member do
      get :confirm
      delete :reject
      delete :cancel
    end
  end
  delete '/trainers/sign_out', to: 'devise/sessions#destroy', as: :trainers_sign_out
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
 
  # Defines the root path route ("/")
  # root "articles#index"
end


