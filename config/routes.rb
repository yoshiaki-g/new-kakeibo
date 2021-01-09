Rails.application.routes.draw do
  devise_for :users
  root "top#index"
  # post "income_values/new(/:name)" => "income_values#new"

  resources :incomes do
    resources :income_values, only:[:index, :create, :new, :edit, :update, :destroy]
  end
  resources :fixedcosts
  resources :fixedcost_values, only:[:index, :create, :new, :edit, :update, :destroy]
  resources :variablecosts
  resources :variablecost_values, only:[:index, :create, :new, :edit, :update, :destroy]
end
