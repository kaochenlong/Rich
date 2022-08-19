Rails.application.routes.draw do

  root "pages#home"
  get "/about", to: "pages#about"

  scope "/@:handler" do
    resource :blogs, except: [:new, :create]
  end
  resource :blogs, only: [:new, :create]

  resource :plans, only: [:show]
  resources :orders, except: [:edit, :update, :destroy] do
    member do
      get :pay
      post :pay, action: "submit_payment"
      delete :cancel
    end
  end

  resources :articles do
    resources :comments, shallow: true, only: [:create, :destroy]

    collection do
      get :search
    end

    member do
      patch :unlock
    end
  end

  # /api/articles/6/like
  namespace :api do
    namespace :v1 do
      resources :articles, only: [] do
        collection do
          get :not_available_dates
        end

        member do
          post :like
        end
      end
    end
  end

  resource :sessions, only: [:create, :destroy]

  resource :users, except: [:new, :destroy] do
    get :sign_up
    get :sign_in
  end

  get "/@:handler", to: "blogs#show"
end
