Rails.application.routes.draw do
  get 'messages/index'

  namespace :api do
    scope '/v1', module: 'v1' do
      post 'index', to: "api#index"
    end
  end

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "messages#index"
end
