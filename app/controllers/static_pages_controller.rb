class StaticPagesController < ApplicationController
	layout "works", except: :frontpage
	
	def frontpage
		render layout: "frontpage"
	end
	
  	def contact

  	end

  	def about
  		
 	end
end
