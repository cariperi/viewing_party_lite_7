Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'welcome#index'

  get 'register', to: 'users#new', as: :new_user

  resources :users, only: [:create, :show] do
    get 'discover', to: 'users/discover#index'
    resources :movies, only: [:index, :show], controller: 'users/movies' do
      resources :viewing_party, only: [:new, :create], controller: 'users/movies/viewing_parties'
    end
  end
end
