# frozen_string_literal: true

Rails.application.routes.draw do
  get 'users/show'
  get 'rooms/index'

  resources :products do
    resources :reviews
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :bproducts do
    resources :breviews
  end

  root 'pages#home'

  resources :interests

  get 'admin/pending_approvals', to: 'admin#pending_approvals'
  get 'admin/confirmed_approvals', to: 'admin#confirmed_approvals'
  get 'admin/create_categories', to: 'admin#create_categories'
  get 'admin/seller', to: 'admin#seller'
  get 'admin/buyer', to: 'admin#buyer'

  # Defines the route for approving and rejecting products
  get 'admin/approve_product/:id', to: 'admin#approve_product', as: 'approve_product'
  get 'admin/reject_product/:id', to: 'admin#reject_product', as: 'reject_product'

  get 'admin/approve_bproduct/:id', to: 'admin#approve_bproduct', as: 'approve_bproduct'
  get 'admin/reject_bproduct/:id', to: 'admin#reject_bproduct', as: 'reject_bproduct'

  match 'admin/approve_product/:id', to: 'admin#approve_product', via: %i[get patch]
  match 'admin/reject_product/:id', to: 'admin#reject_product', via: %i[get patch]

  match 'admin/approve_bproduct/:id', to: 'admin#approve_bproduct', via: %i[get patch]
  match 'admin/reject_bproduct/:id', to: 'admin#reject_bproduct', via: %i[get patch]

  patch 'admin/approve_product/:id', to: 'admin#approve_product'
  patch 'admin/reject_product/:id', to: 'admin#reject_product'

  patch 'admin/approve_bproduct/:id', to: 'admin#approve_bproduct'
  patch 'admin/reject_bproduct/:id', to: 'admin#reject_bproduct'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  delete '/products/:id', to: 'products#destroy', as: 'delete_product'

  delete '/bproducts/:id', to: 'bproducts#destroy', as: 'delete_bproduct'

  get 'user/:id', to: 'users#show', as: 'user'

  resources :rooms do
    resources :messages
  end

  resources :categories

  get 'pages/map', to: 'pages#map'

  get '/products/:id/smail', to: 'products#smail', as: 'smail_product'

  get '/products/:id/sell', to: 'products#sell', as: 'sell_product'

  get '/bproducts/:id/smail', to: 'bproducts#smail', as: 'smail_bproduct'

  get '/bproducts/:id/sell', to: 'bproducts#sell', as: 'sell_bproduct'

  get 'messages', to: 'static_pages#messages'
  get 'messages/open', to: 'messages#create'

  get '/account/', to: 'pages#account', as: 'show_current_account'
  get '/payments/success', to: 'payments#success', as: 'success_payment'
  get '/payments/failure', to: 'payments#failure', as: 'failure_payment'
  post '/payments/webhook', to: 'payments#webhook'
end
