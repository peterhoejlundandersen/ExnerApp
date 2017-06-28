Rails.application.routes.draw do

	get 'pdf-views/show' => 'pdf_views#show', as: 'pdf_view' do
	end

	devise_for :users, path: '', path_names: { sign_in: 'log-in', sign_up: 'opret-bruger' } 
	
	resources :categories, except: :index
	get '/oversigt' => 'categories#index', as: "oversigt"
	
	resources :works do
		put :sort, on: :collection
		member do
			put :sort_images
		end
	end
	
		get "upload_pdfs" => "johannes_writings#upload_pdfs", as: "upload_pdfs"
	resources :johannes_writings do
	end

	get 'om-inger-og-johannes-exner' => 'static_pages#about', as: "om"

	root 'static_pages#frontpage'
end