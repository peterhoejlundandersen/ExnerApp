module ApplicationHelper

	
	def header_title_helper 
		default = "I&J EXNER"
		if @header_title 
			default + " | " + @header_title
		else
			default
		end
	end

	def alert_notice_helper
		if flash[:notice]
			content_tag :p, flash[:notice], class: "alert text-center alert-success"
		elsif flash[:alert]
			content_tag :p, flash[:alert], class: "alert text-center alert-danger"
		end		
	end

	def active_helper? path
		"active" if current_page? path
	end
end

