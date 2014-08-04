Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  root to: 'pages#home'

  get '/about',   to: 'pages#about',   as: :about
  get '/pricing', to: 'pages#pricing', as: :pricing
  get '/contact', to: 'pages#contact', as: :contact

  get '/dashboard', to: 'dashboards#index', as: :dashboard

  # Organisations
  get '/organisations/new',            to: 'organisations#new',       as: :new_organisation
  get '/organisations/:ref',           to: 'organisations#show',      as: :organisation
  get '/organisations/:ref/edit',      to: 'organisations#edit',      as: :edit_organisation
  get '/organisations',                to: 'organisations#index',     as: :organisations
  match '/organisations',              to: 'organisations#create',    as: :create_organisation, via: :post
  match '/organisations/:ref',         to: 'organisations#destroy',   as: :delete_organisation, via: :delete
  match '/organisations/:ref',         to: 'organisations#update',                              via: :patch

  # Users
  get '/users',          to: 'users#index',   as: :users
  get '/users/:id/edit', to: 'users#edit',    as: :edit_user
  get '/users/:id',      to: 'users#show',    as: :user
  get '/users/:id',      to: 'users#destroy', as: :delete_user, via: :delete
  get '/users/:id',      to: 'users#update',                    via: :patch

  # Student Import
  get '/students/import',   to: 'student_imports#new', as: :new_student_import
  get '/students/import',   to: 'student_imports#new', as: :student_imports
  match '/students/import', to: 'student_imports#create', via: :post

  # Courses
  get '/courses',                 to: 'courses#index', as: :courses
  get '/courses/new',             to: 'courses#new',   as: :new_course
  get '/courses/:permalink',      to: 'courses#show',  as: :course
  get '/courses/:permalink/edit', to: 'courses#edit',  as: :edit_course
  match '/courses',               to: 'courses#create',                  via: :post
end
