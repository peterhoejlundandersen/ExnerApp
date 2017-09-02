class CategoriesController < ApplicationController
	access all: [:show, :index], user: {except: [:destroy]}, site_admin: :all
	layout "works"
	def new
		@category = Category.new		
	end
	def edit
		@category = Category.friendly.find(params[:id])		
	end

	def create
		@category = Category.new(cat_params)	
		if @category.save
			redirect_to oversigt_path, notice: "#{@category.name} er blevet gemt"
		else
			redirect_to oversigt_path, alert: "Din kategori blev IKKE gemt, skriv til hilsenit@gmail.com"
		end
	end

	def update
		@category = Category.friendly.find(params[:id])	
		@category.remove_image! if params[:category][:image]
		if @category.update(cat_params)
			redirect_to oversigt_path, notice: "#{@category.name} er blevet opdateret"
		else
			redirect_to oversigt_path, alert: "Din kategori blev IKKE opdateret, skriv til hilsenit@gmail.com"
		end
	end

	def index
		@categories = Category.where.not(id: [15, 18, 13])
		@header_title = "Oversigt"
	end

	def destroy
		@category = Category.friendly.find(params[:id])		
		deleted_name = @category.name
		if @category.destroy
			redirect_to oversigt_path, notice: "#{deleted_name} er blevet slettet"
		else
			redirect_to oversigt_path, alert: "Din kategori blev IKKE slettet, skriv til hilsenit@gmail.com"
		end

	end

	private

	def cat_params
		params.require(:category).permit(:name, :image, :remove_image)
	end

end
