class PdfCategoriesController < ApplicationController
	layout "works"

	def index
		@pdf_categories = PdfCategory.all
		render 'hallo'
			# @pdfs = PdfCategory.friendly.find(params[:category_id]).pdfs
			# @pdf_categories = PdfCategory.all
			# @pdfs = Pdf.all
	end

end
