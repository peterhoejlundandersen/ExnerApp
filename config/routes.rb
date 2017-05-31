Rails.application.routes.draw do
root 'static_pages#frontpage'
  
  devise_for :users, path: '', path_names: { sign_in: 'inger', sign_up: 'opret-bruger' } 

  
  resources :works, except: :index
  get ':category_name/' => 'works#index', as: "kategori-oversigt"

end