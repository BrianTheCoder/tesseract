Tesseract::Application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth'}
  resources :projects, except: [:new, :edit] do
    resources :regions, only: [:index, :show]
    resources :members, only: [:index, :create, :update, :destroy]
    resources :images, only: [:show, :create, :destroy] do
      member do
        post :train
        delete '/train/:region_id', to: :untrain, as: :untrain
      end
    end
  end
  root to: 'projects#index'
end
