class PdfsController < ApplicationController
	def show
		pdf_viewer = "/pdfjs/web/viewer.html?file="
		pdf = Pdf.friendly.find(params[:id])
		@pdf_category = pdf.pdf_category
		pdf == Pdf.last  ? @next_pdf = Pdf.first : @next_pdf = Pdf.find(pdf.id + 1) 
		pdf == Pdf.first ? @prev_pdf = Pdf.last : @prev_pdf = Pdf.find(pdf.id - 1)
		@pdf_url = pdf_viewer + pdf.file
	end

	def edit
		@pdf = Pdf.friendly.find(params[:id])
	end

	def new
		@pdf = Pdf.new()
	end


	private

	def pdf_params
		params.require(:pdf).permit(:title, :file)
	end
end
