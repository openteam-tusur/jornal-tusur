require 'sidekiq/web'

Rails.application.routes.draw do

  mount Sidekiq::Web => '/sidekiq'

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

    resources :claims do
      member do
        post :accept
        post :reject
        post :rollback
      end
    end

    resources :permissions, except: [:edit, :update]
    get 'users/search' => 'users#search', as: :users_search

    get '/', to: redirect('/manage/issues')
  end

  scope 'ru' do


    get 'authors/:id', to: 'authors#show', as: :ru_author

    get 'arhiv', to: 'issues#index', as: :ru_issues
    get 'arhiv/:issue_id', to: 'articles#index', as: :ru_articles
    get 'arhiv/:issue_id/:id', to: 'articles#show', as: :ru_article

    get 'otpravit-statyu', to: 'claims#new', as: :ru_new_claim
    post 'otpravit-statyu', to: 'claims#create', as: :ru_claim_post
    patch 'otpravit-statyu', to: 'claims#create', as: :ru_claim_patch
    get 'otpravit-statyu/statya-otpravlena', to: 'claims#show', as: :ru_claim_sended
  end

  scope 'en' do
    get 'authors/:id', to: 'authors#show', as: :en_author

    get 'archive', to: 'issues#index', as: :en_issues
    get 'archive/:issue_id', to: 'articles#index', as: :en_articles
    get 'archive/:issue_id/:id', to: 'articles#show', as: :en_article

    get 'send-article', to: 'claims#new', as: :en_new_claim
    post 'send-article', to: 'claims#create', as: :en_claim_post
    patch 'send-article', to: 'claims#create', as: :en_claim_patch
    get 'send-article/article-sended', to: 'claims#show', as: :en_claim_sended
  end

  root :to => 'main#index'
  get '(*path)', :to => 'main#index'

end
