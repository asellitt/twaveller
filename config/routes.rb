Rails.application.routes.draw do
  root 'trips#index'

  devise_for :users

  resources :trips do
    resources :areas do
      resources :attractions
    end

    resources :trip_rights
  end

end
