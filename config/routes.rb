Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :teachers

  get '/about',   to: 'pages#about',   as: :about
  get '/pricing', to: 'pages#pricing', as: :pricing
  get '/contact', to: 'pages#contact', as: :contact
end
