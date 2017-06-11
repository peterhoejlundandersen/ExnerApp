Rails.application.routes.draw do

	devise_for :users, path: '', path_names: { sign_in: 'log-in', sign_up: 'opret-bruger' } 
	
	resources :categories, except: :index
	get '/oversigt' => 'categories#index', as: "oversigt"
	
	resources :works do
		put :sort, on: :collection
	end
	
	get 'vaerker/:category_name/' => 'works#banan', as: "kategori-oversigt"
	

	get 'om-inger-og-johannes-exner' => 'static_pages#about', as: "om"

	get 'billede-uploader' => 'image_uploaders#uploader', as: "image_uploader"
	post 'billede-uploader' => 'image_uploaders#create'
	
	root 'static_pages#frontpage'
end