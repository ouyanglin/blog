Blog::Application.routes.draw do
  resources :sessions, :only => [:new, :create, :destroy]
  resources :users
  resources :posts, :only => [:create, :destroy, :edit, :update, :new]

  match '/signin'  => 'sessions#new'
  match '/signout' => 'sessions#destroy'

  match '/about' => 'pages#about'
  match '/dashboard' => 'pages#dashboard'

  match '/request_token' => 'users#request_token'
  match '/access' => 'users#access'

  match '/posts/:title' => 'posts#show'

  match '/label/:id' => 'labels#show', :as => "label"

  root :to => "pages#home"
end
