module WorksHelper

	def logged_in_work_helper 

			buttons = (link_to "Slet værket", work_path(@work), method: :delete, data: {confirm: "Er du sikker på, at du vil slette værket?"}, class: "btn btn-warning") + (
			link_to "Rediger værk", edit_work_path(@work), class: "btn btn-secondary")
			
			content_tag :div, buttons, class: "col-lg-12" 

	end

	def img_cat_col_helper img_cat_num
		case img_cat_num
		when 1
			12
		when 2
			6
		when 3
			4
		when 4
			3
		when 5
			2
		end

	end
end
