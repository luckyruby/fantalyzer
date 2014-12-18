Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :players do
    member do
      get 'games' => 'games#index'
    end
    collection do
      get 'games' => 'players#games'
      get 'salaries' => 'players#salaries'
      post 'load_salaries' => 'players#load_salaries'
    end
  end

  get "profile/edit"
  patch "profile/update"

  root 'players#index'
end
