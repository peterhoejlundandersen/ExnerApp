class PdfCategoriesController < ApplicationController
	layout "works"

	def index
		@cat_headline = "Alle"
		@pdf_categories = PdfCategory.all
		@pdfs = Pdf.all
	end

	def show_category
		@pdf_cat = PdfCategory.friendly.find(params[:kategori_id])
		@pdf_categories = PdfCategory.all
		@pdfs = @pdf_cat.pdfs
		@cat_headline = @pdf_cat.title
		render 'index'
	end

end
