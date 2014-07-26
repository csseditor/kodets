Rails.application.routes.draw do

  root to: 'pages#home'

  devise_for :teachers, controllers: { registrations: 'registrations' }
  devise_for :students

  get '/about',   to: 'pages#about',   as: :about
  get '/pricing', to: 'pages#pricing', as: :pricing
  get '/contact', to: 'pages#contact', as: :contact

  get '/dashboard', to: 'dashboards#index', as: :dashboard

  get '/organisations/new',            to: 'organisations#new',       as: :new_organisation
  get '/organisations/:ref',           to: 'organisations#show',      as: :organisation
  get '/organisations/:ref/edit',      to: 'organisations#edit',      as: :edit_organisation
  get '/organisations',                to: 'organisations#index',     as: :organisations
  match '/organisations',              to: 'organisations#create',    as: :create_organisation, via: 'post'
  match '/organisations/:ref',         to: 'organisations#destroy',   as: :delete_organisation, via: 'delete'
  match '/organisations/:ref',         to: 'organisations#update',                              via: 'patch'

  get '/students/import',   to: 'students#import_view', as: :import_students_view
  get '/students',          to: 'students#index',       as: :students
  match '/students/import', to: 'students#import',      as: :import_students, via: :post
end
