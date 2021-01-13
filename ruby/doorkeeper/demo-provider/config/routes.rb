Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users
  resources :articles

  namespace :api do
    namespace :v1 do
      resources :projects
      get '/me' => 'credentials#me'
    end
  end

  get 'welcome/index'
  root 'welcome#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
