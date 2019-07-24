# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'

  resources :articles

  namespace :time do
    resource :now, only: [:show], controller: 'now'
  end
end
