Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  get '/about',   to: 'pages#about',   as: :about
  get '/pricing', to: 'pages#pricing', as: :pricing
  get '/contact', to: 'pages#contact', as: :contact
end
