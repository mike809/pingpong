Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  get '/history', to: 'home#history'
  get '/log',     to: 'home#log'
  post '/log',    to: 'home#log_game', as: :log_game
end
