Rails.application.routes.draw do

  namespace :manage do
    resources :issues
    resources :permissions, except: [:edit, :update]
    get 'users/search' => 'users#search', as: :users_search
    get '/', to: redirect('/manage/issues')
  end

  root 'welcome#index'

end
