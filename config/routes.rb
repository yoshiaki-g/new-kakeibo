Rails.application.routes.draw do
  devise_for :users
  root "top#index"
  # post "income_values/new(/:name)" => "income_values#new"

  resources :incomes 
  resources :fixedcosts
  resources :variablecosts
end
