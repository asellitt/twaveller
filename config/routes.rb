Rails.application.routes.draw do
  root 'trips#index'

  devise_for :users

  resources :trips do
    resources :areas do
      resources :attractions
    end
  end

  resources :trip_rights
end
