Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }
  root 'pages#home'
  resources :reports
  get '/report_users/:id', to: 'reports#report_users', as: 'report_users'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
