Rails.application.routes.draw do
  resources :players do
    member do
      get 'games' => 'games#index'
    end
    collection do
      get 'salaries' => 'players#salaries'
      post 'load_salaries' => 'players#load_salaries'
    end
  end
  root 'players#index'
end
