class StaticPagesController < ApplicationController
	layout "works", except: [:frontpage]
	
	def frontpage
		if FrontpageText.all.any?
			@text = FrontpageText.last
		else
			@text = nil
		end
		render layout: "frontpage" 
	end
	
  	def contact

  	end

  	def about
		@header_title = "Om Inger & Johannes"   		
 	end

 	def new_frontpage_text
 		@text = FrontpageText.new()
 	end

 	def edit_frontpage_text
		@text = FrontpageText.find(params[:text_id])
 	end

 	def create_frontpage_text 
 		@text = FrontpageText.new(frontpage_text_params)
 		if @text.save
 			redirect_to root_path
 		else
 			redirect_to root_path, notice: "Noget gik galt!"
 		end 
 	end
 	def update_frontpage_text 
 		@text = FrontpageText.find(params[:id])
 		if @text.update(frontpage_text_params)
 			redirect_to root_path
 		else
 			redirect_to root_path, notice: "Noget gik galt!"
 		end 

 	end


 	private

 	def frontpage_text_params
 		params.require(:frontpage_text).permit(:text)
 	end 
 		
end
