Rails.application.routes.draw do

  namespace :manage do
    resources :issues
    root 'issues#index'
  end

  root 'welcome#index'

end
