Rails.application.routes.draw do
  get 'messages/new'
  get 'messages/index'
  get 'rooms/index'
  get 'chats/show'
  get 'ratings/new'
  get 'ratings/create'
  get 'ratings/update'
  # get 'comments/create'
  # get 'comments/destroy'
  root to: "homes#index"
  get 'appointments/new'
  get 'appointments/create'
  get 'posts/new'
  get 'posts/create'
  get 'posts/show'
  
  devise_for :users
  
  # devise_scope :users do
  #    get 'users/:id', to: 'registrations#show', as: 'user'
  # end

 resources :rooms do
  resources :messages
 end
  
resources :clients
# resources :trainers
resources :trainers do
  resources :appointments, only: [:new, :create]
  resources :ratings
  resources :posts do
    resources :comments
  end
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

  get '/trainers/:trainer_id/My_Clients', to: 'trainers#show_clients', as: "my_clients"
  delete '/trainers/sign_out', to: 'devise/sessions#destroy', as: :trainers_sign_out
  
  get 'user/:id', to: 'trainers#show', as: 'user'
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
 
  # Defines the root path route ("/")
  # root "articles#index"
  
end


