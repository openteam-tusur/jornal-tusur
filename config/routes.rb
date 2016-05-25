Rails.application.routes.draw do

  namespace :manage do
    resources :issues, except: [:show] do
      resources :articles
    end

    resources :sections, except: [:show]

    resources :permissions, except: [:edit, :update]
    get 'users/search' => 'users#search', as: :users_search

    get '/', to: redirect('/manage/issues')
  end

  root 'welcome#index'

end
