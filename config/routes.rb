Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users, controllers: {registrations: 'users/registrations', sessions: 'users/sessions'}
  resources :users do
    resource :profile
  end
  patch '/users/:id/verify', :to => 'users#verify'
  get '/about', to: 'pages#about'
  resources :contacts, only: :create
  get 'contact-us', to: 'contacts#new', as: 'new_contact'
end
