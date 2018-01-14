class PdfCategoriesController < ApplicationController
	layout "works"

	def show_category
		byebug
		if ["andres-tekster-andre-sprog", "andres-tekster"].include? params[:kategori_id] # Hvis det er andres artikler
			redirect_to artikler_path()
		else
			@pdf_cat = PdfCategory.friendly.find(params[:kategori_id])
			@pdf_categories = PdfCategory.not_about
			@pdfs = user_signed_in? ? @pdf_cat.pdfs : @pdf_cat.pdfs.where.not(show_not: true) # Hvis du er logget ind, så vis alle pdf'er
			@cat_headline = @pdf_cat.title

			@breadcrumb_parent = {title: "Johannes' tekster", path: "show_this_pdf_category_path('aeldre-arkitekter')"}
			@breadcrumb_child = {title: @cat_headline, path: "show_this_pdf_category_path('#{@pdf_cat.slug}')"}
			render 'index'
		end
	end

end
