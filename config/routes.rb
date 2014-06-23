Rails.application.routes.draw do
  devise_for :organisations
  devise_for :users, controllers: { sessions: 'user_sessions', registrations: 'user_registrations' }

  root to: 'pages#home'

  get '/about',   to: 'pages#about',   as: :about
  get '/pricing', to: 'pages#pricing', as: :pricing
  get '/contact', to: 'pages#contact', as: :contact
end
