class TextsController < ApplicationController
	before_action :authenticate_user!
	layout 'works'
	def new
		if Text.last.nil?  # Der kan kun være én
			@text = Text.new
		else
			redirect_to edit_text_path(Text.last.id) # Der kan kun være én!
		end
	end

	def create
		@text = Text.new(text_params)
		if @text.save
			flash[:notice] = "Din tekst er blevet gemt"
			redirect_to show_this_pdf_category_path(0)
		else
			flash.now[:notice] = "Noget gik galt, prøv igen"
			render :new
		end
	end

	def edit
		@text = Text.find(params[:id])
	end

	def update
		@text = Text.find(params[:id])
		if @text.update(text_params)
			flash[:notice] = "Din tekst er blevet opdateret"
			redirect_to show_this_pdf_category_path(0)
		else
			flash.now[:notice] = "Noget gik galt, prøv igen"
			render :edit
		end
	end

	def text_params
		params.require(:text).permit(:text)
	end
end
