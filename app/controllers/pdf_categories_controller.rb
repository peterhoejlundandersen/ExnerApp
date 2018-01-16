class PdfCategoriesController < ApplicationController
	before_action :authenticate_user!, except: :show_category
	layout "works"

	def show_category
		if ["andres-tekster-andre-sprog", "andres-tekster"].include? params[:kategori_id] # Hvis det er andres artikler
			redirect_to artikler_path()
		else
			@breadcrumb_parent = {title: "Johannes' tekster", path: "show_this_pdf_category_path('0')"}
			if params[:kategori_id] == "0" && !Text.last.nil? # Intro og tekst er oprettet
				@pdf_categories = PdfCategory.not_about
				@cat_headline = "Intro"
				@text = Text.last
				@breadcrumb_child = {title: @cat_headline, path: "show_this_pdf_category_path('0')"}
			else
				@pdf_cat = params[:kategori_id] == "0" ? PdfCategory.first : PdfCategory.friendly.find(params[:kategori_id])
				@pdf_categories = PdfCategory.not_about
				@pdfs = user_signed_in? ? @pdf_cat.pdfs : @pdf_cat.pdfs.where.not(show_not: true) # Hvis du er logget ind, så vis alle pdf'er
				@cat_headline = @pdf_cat.title
				@breadcrumb_child = {title: @cat_headline, path: "show_this_pdf_category_path('#{@pdf_cat.slug}')"}
			end
			render 'index'
		end
	end

end
