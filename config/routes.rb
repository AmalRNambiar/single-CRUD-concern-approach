Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  root 'questions#index'
  
  resources :questions
  resources :answers
  resources :comments do
  	get :vote
  end

end
