Rails.application.routes.draw do

  namespace :manage do
    resources :issues, except: [:show] do

      member do
        post :approve
        post :rollback
      end

      resources :articles do
        resources :authors, only: [:new, :create, :destroy]
      end

    end

    resources :sections, except: [:show]

    resources :authors, only: [] do
      get 'search', on: :collection
      get 'directory_search', on: :collection
    end

    resources :permissions, except: [:edit, :update]
    get 'users/search' => 'users#search', as: :users_search

    get '/', to: redirect('/manage/issues')
  end

  scope 'ru' do
    get 'arhiv', to: 'issues#index', as: :ru_issues
    get 'arhiv/:issue_id', to: 'articles#index', as: :ru_articles
  end

  root :to => 'main#index'
  get '(*path)', :to => 'main#index'

end
