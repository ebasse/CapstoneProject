Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "user/registrations" }
  
  
  root 'welcome#index'
  resources :users, only: [:show] #place holder to view board link maybe
  resources :memberships
  get 'my_members', to: 'users#my_members'
  get 'search_members', to: 'users#search'
  post 'add_member', to: 'users#add_member'
  get 'tutorial/index'
  resources :boards do
    resources :tasks do
        resources :comments
    end
end
  
  root 'welcome#index'
  get 'board/index'
  
   post 'tasks/update_pos' => 'tasks#update_pos'
   get 'tasks/ajax_show' => 'tasks#ajax_show'
   get 'tasks/get_pos' => 'tasks#get_pos'
   
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
