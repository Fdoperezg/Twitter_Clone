Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { registrations: 'registrations' }
  get 'api/news', to: 'tweeets#news'
  get 'api/:fecha1/:fecha2', to: 'tweeets#date'
  
  resources :tweeets do
    member do
      post :retweet
    end
    resources :friendships, only: [:create] 
  end
  resources :likes
  post 'friendships/update/:id', to: 'friendships#update' , as: 'friendships_update' 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root "tweeets#index"
end