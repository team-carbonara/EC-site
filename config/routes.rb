Rails.application.routes.draw do

  namespace :public do
    get 'cart_products/index'
  end
  namespace :admin do
    root to: 'admin/products#index'
    resources :products
    resources :genres
    resources :customers, only: [:index,:show,:edit,:update]
    resources :orders,only: [:index,:show,:edit,:update]
    resources :order_products,only: [:update]
  end

  namespace :public do
  root to: 'homes#top'
  get '/about' => 'homes#about'
  delete '/cart_products' => '/public/cart_products#destroy_all'
  resources :customers,only: [:edit,:update] do
    collection do
      get 'show'
      get 'unsubscribe'
    end
    patch 'withdrawal'
  end
  resources :products, only: [:index,:show]
  resources :cart_products, only: [:index,:create,:update,:destroy]
  resources :deliveries,only: [:index,:edit,:create,:update,:destroy]
  resources :orders,only: [:index,:show,:new,:create,] do
    member do
      get 'check'
      get 'thanks'
    end
  end
    resource :customer, only: [:show, :edit] do
      collection do
    get 'unsubscribe', action: :unsubscribe
      end
    end
  end

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords,], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
  }

end
