Rails.application.routes.draw do


  get 'pdfs/show'

  get 'pdfs/edit'

  get 'pdfs/new'

	devise_for :users, path: '', path_names: { sign_in: 'log-in', sign_up: 'opret-bruger' } 
	
	resources :categories, except: :index
	get '/oversigt' => 'categories#index', as: "oversigt"
	
	resources :works, except: :index do
		put :sort, on: :collection
		member do
			put :sort_images
		end
	end
	get 'vaerker/:vaerker_cat' => 'works#index', as: :vaerker 
	

	### PDFS ### 	

	resources :pdf_categories, except: [:index] do 
		resources :pdfs, except: [:index] 
	end 
	get "pdf-kategori/:slug/:category_id" => "pdf_categories#index", as: "show_pdf_category"

	# get "upload_pdfs_via_s3/now" => "pdf_categories#upload_pdfs_via_s3", as: "upload_pdfs_via_s3"

	get 'pdf-views/show' => 'pdf_views#show', as: 'pdf_view'

	### PDFS END ### 

	get 'om-inger-og-johannes-exner' => 'static_pages#about', as: "om"

	root 'static_pages#frontpage'
end