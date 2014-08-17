Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'registrations' }

  root to: 'pages#home'

  # Static Pages
  get '/about',   to: 'pages#about',   as: :about
  get '/pricing', to: 'pages#pricing', as: :pricing
  get '/contact', to: 'pages#contact', as: :contact
  get '/features', to: 'pages#features', as: :features

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
  resources :courses

  # Tracks
  get '/courses/:id/tracks',     to: 'tracks#index', as: :tracks
  get '/courses/:id/tracks/new', to: 'tracks#new',   as: :new_track
  get '/tracks/:id',             to: 'tracks#show',  as: :track
  get '/tracks/:id/edit',        to: 'tracks#edit',  as: :edit_track
  match '/courses/:id/tracks',   to: 'tracks#create',                 via: :post

  # Code Lessons
  get '/tracks/:id/code-lessons/new', to: 'code_lessons#new',     as: :new_code_lesson
  get '/tracks/:id/code-lessons',     to: 'code_lessons#index',   as: :code_lessons
  get '/code-lessons/:id',            to: 'code_lessons#show',     as: :code_lesson
  get '/code-lessons/:id/edit',       to: 'code_lessons#edit',    as: :edit_code_lesson
  match '/code-lessons/:id',          to: 'code_lessons#destroy', as: :delete_code_lesson, via: :delete
  match '/code-lessons/:id',          to: 'code_lessons#update',                           via: :patch
  match '/tracks/:id/code-lessons',   to: 'code_lessons#create',  as: :create_code_lesson, via: :post
end
