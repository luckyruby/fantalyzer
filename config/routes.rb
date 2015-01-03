Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :players do
    collection do
      get 'games' => 'players#games'
      get 'salaries' => 'players#salaries'
      post 'load_salaries' => 'players#load_salaries'
    end
  end

  get "profile/edit"
  patch "profile/update"
  get "lineup/calculator"

  root 'players#index'
end
