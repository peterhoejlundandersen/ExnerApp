Rails.application.routes.draw do
root 'static_pages#frontpage'

  devise_for :users, path: '', path_names: { sign_in: 'log-in', sign_up: 'opret-bruger' } 
  
  resources :categories, except: :index
  get '/oversigt' => 'categories#index', as: "oversigt"
  
  resources :works, except: :index
  get ':category_name/' => 'works#index', as: "kategori-oversigt"

end