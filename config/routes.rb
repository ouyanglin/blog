Blog::Application.routes.draw do
  get "users/new"

  match '/about' => 'pages#about'
  match '/dashboard' => 'pages#dashboard'

  root :to => "pages#home"
end
