Rails.application.routes.draw do

  namespace :admin do
    root 'products#index'
    resources :products
    resources :genres
    resources :customers, only: [:index,:show,:edit,:update]
    resources :orders,only: [:index,:show,:edit,:update]
    resources :order_products,only: [:update]
  end

  scope module: :public do
    root 'homes#top'
    get '/about' => 'homes#about'

    resource :customers,only: [:edit,:update,:show] do
      collection do
        get 'unsubscribe'
      end
      patch 'withdrawal'
    end
    resources :products, only: [:index,:show]
    resources :cart_products, only: [:index,:create,:update,:destroy] do
      collection do
        delete '/' => '/customer/cart_products#destroy_all'
      end
    end
    resources :deliveries,only: [:index,:edit,:create,:update,:destroy]
    resources :orders,only: [:index,:show,:new,:create,] do
      collection do
        get 'check'
        get 'thanks'
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