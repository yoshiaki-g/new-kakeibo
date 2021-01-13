Rails.application.routes.draw do
  devise_for :users
  root "top#index"
  get "balance_confirm" => "balance_confirm#index"
  post "balance_confirm/show(/:name)" => "balance_confirm#show"
  get "balance_confirm/show(/:name)" => "balance_confirm#show"
  post "blance_confirm/show_year(/:name)" => "balance_confirm#show_year"
  get "blance_confirm/show_year(/:name)" => "balance_confirm#show_year"
  
  resources :incomes 
  resources :fixedcosts
  resources :variablecosts
end
