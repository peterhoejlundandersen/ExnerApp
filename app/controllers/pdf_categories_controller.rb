class PdfCategoriesController < ApplicationController
	layout "works"

	def index
		unless params[:category_id] == "0"
			@pdf_categories = PdfCategory.all
 			@pdfs = Pdf.where(pdf_category_id: params[:category_id].to_i)
		else 
			@pdf_categories = PdfCategory.all
			@pdfs = Pdf.all
		end
	end

end
