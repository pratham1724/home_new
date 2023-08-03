Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
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

  get '/clients/:client_id/My_Trainers', to: 'clients#show_trainers', as: "my_trainers"
  get "/client/:client_id", to: "chats#private_chat", as: "client_private_chat"
  get "/trainer/:trainer_id", to: "chats#private_chat", as: "trainer_private_chat"
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
  resources :appointments
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
  get '/trainers/:trainer_id/Pending_Appointments', to: 'trainers#show_pendings', as: "pending_appointments"
  get '/trainers/:trainer_id/My_Clients', to: 'trainers#show_clients', as: "my_clients"
  delete '/trainers/sign_out', to: 'devise/sessions#destroy', as: :trainers_sign_out
  
  get 'user/:id', to: 'trainers#show', as: 'user'
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
 
  # Defines the root path route ("/")
  # root "articles#index"
  
end


