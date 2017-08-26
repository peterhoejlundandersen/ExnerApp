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
			get :new_image
			get :new_image_category
		end
	end
	get 'vaerker/:vaerker_cat' => 'works#index', as: :vaerker 

	get 'vaerker/design/:vaerker_cat' => 'works#design_index', as: :vaerker_design	

	### PDFS ### 	

	resources :pdf_categories, except: [:index] do 
		resources :pdfs, except: [:index] 
	end 

	get "pdf-kategori/vis-alle" => "pdf_categories#index", as: "show_pdf_category"

	get "pdf-kategori/:kategori_id" => "pdf_categories#show_category", as: "show_this_pdf_category" 

	get 'pdf-views/show' => 'pdf_views#show', as: 'pdf_view'

	### PDFS END ### 

	get 'om-inger-og-johannes-exner' => 'static_pages#about', as: "om"

	#FORSIDE TEKST
	get 'forside/ny-forside-tekst' => 'static_pages#new_frontpage_text', as: :ny_forside_tekst
	get 'forside/rediger-forside-tekst/:text_id' => 'static_pages#edit_frontpage_text', as: :rediger_forside_tekst
	post 'forside/opret-forside-tekst' => 'static_pages#create_frontpage_text', as: :opret_forside_tekst
	patch 'forside/opdater-tekst/:id' => 'static_pages#update_frontpage_text', as: :opdater_forside_tekst 
	# END FORSIDE TEKST
	root 'static_pages#frontpage'
end