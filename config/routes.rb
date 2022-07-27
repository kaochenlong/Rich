Rails.application.routes.draw do
  get "/", to: "welcome#home"
  get "/about", to: "pages#about"

  get "/blog", to: "blog#index"
  get "/blog/new", to: "blog#new"
  post "/blog", to: "blog#create"
end
