class StaticPagesController < ApplicationController
	layout false, only: :frontpage

	def frontpage
	@categories = Category.all
	@first_category = @categories.first
	end
	
  	def contact
  	end

  	def about
 	end
end
