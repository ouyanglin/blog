Blog::Application.routes.draw do
  resources :sessions, :only => [:new, :create, :destroy]
  resources :users
  resources :posts

  match '/signin'  => 'sessions#new'
  match '/signout' => 'sessions#destroy'

  match '/about' => 'pages#about'
  match '/dashboard' => 'pages#dashboard'

  root :to => "pages#home"
end
