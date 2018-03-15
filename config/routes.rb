Rails.application.routes.draw do
  resources :external_subscriptions
  resources :subscriptions
  resources :investors
  resources :projects
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
