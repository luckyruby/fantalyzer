Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :players do
    collection do
      get 'games' => 'players#games'
      get 'projections' => 'players#projections'
    end
  end
  resources :salaries do
    collection do
      post 'load' => 'salaries#load'
    end
  end

  resources :projections

  get "profile/edit"
  patch "profile/update"
  get "lineup/calculator"

  root 'players#index'
end
