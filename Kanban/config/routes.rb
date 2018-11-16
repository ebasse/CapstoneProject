Rails.application.routes.draw do
  resources :boards do
    resources :tasks
  end
  get 'board/index'
  
   post 'tasks/update_pos' => 'tasks#update_pos'
   get 'tasks/ajax_show' => 'tasks#ajax_show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
