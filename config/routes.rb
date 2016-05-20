Rails.application.routes.draw do

  namespace :manage do
    resources :issues
    resources :permissions, except: [:edit, :update]
    get 'users/search' => 'users#search', as: :users_search
    root 'issues#index'
  end

  root 'welcome#index'

end
