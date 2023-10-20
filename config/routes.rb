# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'entries#index'

  # Resource based routes
  resources :subscriptions
  resources :entries

  # Special routes for sign in/out and profile
  scope :users do
    resource :session, only: [], path: '' do
      get :new, path: '/sign_in', as: :new
      post :create, path: '/sign_in'
      delete :destroy, path: '/sign_out', as: :destroy
    end

    resource :password, only: %i[new create edit update]

    resource :user, path: 'profile', only: %i[update] do
      get :edit, path: ''
    end
  end

  # Only allow access to GoodJob dashboard if user is an admin
  constraints(->(request) { User.find_by(id: request.session[:user_id])&.admin? }) do
    mount GoodJob::Engine => 'good_job'
  end
end
