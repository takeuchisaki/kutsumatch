Rails.application.routes.draw do

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions:       'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about', as: 'about'
    resources :customers, only: [:new, :create, :show, :index, :edit, :update]
    get 'customers/confirm' => 'customers#confirm', as: 'customer_confirm'
    patch 'customers/withdraw' => 'customers#withdraw', as: 'customer_withdraw'
    resources :shoes, only: [:new, :create, :show, :index, :edit, :update, :destroy]
  end

  namespace :admin do
    root to: 'home#top'
    resources :shoes,     only: [:index, :show, :destroy]
    resources :genres,    only: [:index, :create, :edit, :update]
    resources :costomers, only: [:index, :show, :edit, :update]
  end

  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'customers/sessions#guest_sign_in'
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
