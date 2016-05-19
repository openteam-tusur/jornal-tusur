Rails.application.routes.draw do

  namespace :manage do
    root 'application#index'
  end

  root 'welcome#index'

end
