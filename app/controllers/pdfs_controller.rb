class PdfsController < ApplicationController
	layout "works", except: :show

	def show
		pdf_viewer = "/pdfjs/web/viewer.html?file="
		pdf = Pdf.friendly.find(params[:id])
		@pdf_category = pdf.pdf_category
		pdf == Pdf.last  ? @next_pdf = Pdf.first : @next_pdf = Pdf.find(pdf.id + 1) 
		pdf == Pdf.first ? @prev_pdf = Pdf.last : @prev_pdf = Pdf.find(pdf.id - 1)
		@pdf_url = pdf_viewer + pdf.file
		@pdf_file_url = pdf.file # For printinh
		@header_title = pdf.title
	end

	def edit
		@pdf = Pdf.friendly.find(params[:id])
		@category = @pdf.pdf_category
		@categories = PdfCategory.all
	end

	def update
		@pdf = Pdf.friendly.find(params[:id])
		if @pdf.update(pdf_params)
			flash[:notice] = "\"#{@pdf.title}\" er blevet opdateret."
			redirect_to show_pdf_category_path("Alle", 0)
		else
			flash[:notice] = "Der gik noget galt. Prøv igen."
			render "edit"
		end
	end

def new
	@pdf = Pdf.new()
end


private

def pdf_params
	params.require(:pdf).permit(:title, :pdf_category_id)
end
end
