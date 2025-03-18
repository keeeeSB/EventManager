Rails.application.routes.draw do
  devise_for :users

  root "static_pages#home"

  resources :users, only: [ :show ] do
    resources :events, only: [ :new, :create, :show, :edit, :update, :destroy ]
  end
  resources :events, only: [ :index ] do
    resources :favorites, only: [ :create, :destroy ]
    resources :reviews,   only: [ :create, :edit, :update, :destroy ]
    resources :participations, only: [ :create, :destroy ]
  end
end
