module ApplicationHelper

	def header_title
		default = "I&J EXNER"
		if @header_title 
			default + " | " + @header_title
		else
			default
		end
	end
end
