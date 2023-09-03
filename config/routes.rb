# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'entries#index'

  # Resource based routes
  resources :feeds
  resources :entries

  # Special routes for sign in/out and profile
  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  delete '/sign_out', to: 'sessions#destroy'

  get '/profile', to: 'users#edit'
  patch '/profile', to: 'users#update'

  # Only allow access to GoodJob dashboard if user is an admin
  constraints(->(request) { User.find_by(id: request.session[:user_id])&.admin? }) do
    mount GoodJob::Engine => 'good_job'
  end
end
