Rails.application.routes.draw do
root 'static_pages#frontpage'
  
  devise_for :users, path: '', path_names: { sign_in: 'inger', sign_up: 'opret-bruger' } 

  get ':category_name/' => 'categories#index', as: "kategori-oversigt"
  
  resources :works, except: :index
end