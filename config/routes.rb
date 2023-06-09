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
    get   'about'               => 'homes#about',         as: 'about'
    get   'customers/confirm'   => 'customers#confirm',   as: 'customer_confirm'
    patch 'customers/withdraw'  => 'customers#withdraw',  as: 'customer_withdraw'
    resources :customers, only: [:new, :create, :show, :index, :edit, :update] do
      get :keeps, on: :collection
      get :shoe_comments, on: :collection
      resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers"  => "relationships#followers",  as: "followers"
    end
    resources :shoes, only: [:new, :create, :show, :index, :edit, :update, :destroy] do
      resources :shoe_comments, only: [:create, :destroy]
      resource  :keeps,         only: [:create, :destroy]
    end
    get "search" => "searches#search"
  end

  namespace :admin do
    root to: 'homes#top'
    resources :shoes,         only: [:index, :show, :destroy]
    resources :customers,     only: [:index, :show, :edit, :update]
    resources :shoe_comments, only: [:index, :show, :destroy]
  end


  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
