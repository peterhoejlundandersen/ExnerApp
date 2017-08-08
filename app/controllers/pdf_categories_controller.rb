class PdfCategoriesController < ApplicationController
	layout "works"

	def index
		unless params[:category_id] == "0"
			@pdf_categories = PdfCategory.all
			@pdfs = PdfCategory.friendly.find(params[:category_id]).pdfs
		else 
			@pdf_categories = PdfCategory.all
			@pdfs = Pdf.all
		end
	end

end
