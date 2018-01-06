class PdfCategoriesController < ApplicationController
	layout "works"

	def index
    @pdf_categories = PdfCategory.not_about # Not id 1, 2 - default .not scope in model
	end

	def show_category
		@pdf_cat = PdfCategory.friendly.find(params[:kategori_id])
		@pdf_categories = PdfCategory.not_about
		@pdfs = @pdf_cat.pdfs
		@cat_headline = @pdf_cat.title
		render 'index'
	end

end
