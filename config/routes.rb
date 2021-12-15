Rails.application.routes.draw do


  namespace :public do
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
