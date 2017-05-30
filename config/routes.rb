Rails.application.routes.draw do

  devise_for :users

  # token auth routes available at /api/v1/auth
  namespace :api do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', skip: [:passwords, :registrations, :confirmations, :unlocks], controllers: {
        sessions:  'api/v1/sessions'
      }
    end
  end

  # mount_devise_token_auth_for 'User', at: 'auth'
  get 'messages/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "messages#index"
end
