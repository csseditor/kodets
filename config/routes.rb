Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :teachers, controllers: { registrations: 'registrations' }
  devise_for :students

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

  # Student Import
  get '/students/import',   to: 'student_imports#new', as: :new_student_import
  get '/students/import',   to: 'student_imports#new', as: :student_imports
  match '/students/import', to: 'student_imports#create', via: :post

  # Students
  get '/students',          to: 'students#index',       as: :students
  get '/students/:id',      to: 'students#show',        as: :student
  get '/students/:id/edit', to: 'students#edit',        as: :edit_student
  match '/students/:id',    to: 'students#destroy',     as: :destroy_student, via: :delete
end
