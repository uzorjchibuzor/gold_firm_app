# frozen_string_literal: true

Rails.application.routes.draw do
  resources :examinations
  devise_for :users

  get "users/:id", to: "profiles#show", as: "show_profile"
  get "session_details", to: "profiles#session_details", as: "session_details"

  get "home/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Admin Routes Starts
  post "admin/manage_users/enroll_user", to: "admin/manage_users#enroll_user", as: "enroll_user"
  post "admin/manage_users/unenroll_user", to: "admin/manage_users#unenroll_user", as: "unenroll_user"
  post "admin/manage_users/disable_user", to: "admin/manage_users#disable_user", as: "disable_user"
  namespace :admin do
    get "school_years/create"
    get "school_years/destroy"
    get "school_years/edit"
    get "school_years/index"
    get "school_years/new"
    get "school_years/update"
    resources :manage_users
  end
  # Admin Routes Ends

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "home#index"
end
