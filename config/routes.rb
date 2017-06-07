Rails.application.routes.draw do

	devise_for :users, path: '', path_names: { sign_in: 'log-in', sign_up: 'opret-bruger' } 
	
	resources :categories, except: :index
	get '/oversigt' => 'categories#index', as: "oversigt"
	
	resources :works, except: :index
	get 'vaerker/:category_name/' => 'works#index', as: "kategori-oversigt"
	get 'om-inger-og-johannes-exner' => 'static_pages#about', as: "om"

	root 'static_pages#frontpage'
end