class PdfCategoriesController < ApplicationController
	layout "works"

	def index
    @pdf_categories = PdfCategory.not_about # Not id 1, 2 - default .not scope in model
    @pdf_cat = @pdf_categories.first
    @pdfs = user_signed_in? ? @pdf_cat.pdfs : @pdf_cat.pdfs.where.not(show_not: true) # Hvis du er logget ind, så vis alle pdf'er
    @cat_headline = @pdf_cat.title
	end

	def show_category
		@pdf_cat = PdfCategory.friendly.find(params[:kategori_id])
		@pdf_categories = PdfCategory.not_about
    @pdfs = user_signed_in? ? @pdf_cat.pdfs : @pdf_cat.pdfs.where.not(show_not: true) # Hvis du er logget ind, så vis alle pdf'er
		@cat_headline = @pdf_cat.title
		render 'index'
	end

end
