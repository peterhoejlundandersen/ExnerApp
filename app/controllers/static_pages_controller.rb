class StaticPagesController < ApplicationController
	layout "frontpage", only: :frontpage

	def frontpage
	@categories = Category.all
	@first_category = @categories.first
	end
	
  	def contact
  	end

  	def about
 	end
end
