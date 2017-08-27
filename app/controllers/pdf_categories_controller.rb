class PdfCategoriesController < ApplicationController
	layout "works"

	def index
		@pdf_categories = PdfCategory.all
		@pdfs = Pdf.all
	end

	def show_category
		@pdfs = PdfCategory.find(params[:kategori_id]).pdfs
		respond_to do |format|
			format.js
		end
	end

end
