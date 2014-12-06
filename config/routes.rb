Rails.application.routes.draw do
  resources :players do
    member do
      get 'games' => 'games#index'
    end
  end
  root 'players#index'
end
