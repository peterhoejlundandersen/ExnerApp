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
	
	get "upload_pdfs/now" => "pdf_categories#upload_pdfs", as: "upload_pdfs"
	get "upload_pdfs_via_s3/now" => "pdf_categories#upload_pdfs_via_s3", as: "upload_pdfs_via_s3"
	resources :pdf_categories do
	end

	resources :pdfs, controller: "pdf_categories"

	get 'om-inger-og-johannes-exner' => 'static_pages#about', as: "om"

	root 'static_pages#frontpage'
end