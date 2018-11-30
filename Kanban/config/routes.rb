Rails.application.routes.draw do
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
