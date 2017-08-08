class PdfCategoriesController < ApplicationController
	layout "works"

	def index
		@pdf_categories = PdfCategory.all
		@pdfs = PdfCategory.find(params[:category_id]).pdfs
		render 'hallo'
			# @pdf_categories = PdfCategory.all
			# @pdfs = Pdf.all
	end

end
